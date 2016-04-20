{CompositeDisposable} = require 'atom'
Glossary = require './glossary/Glossary'
Readme   = require './glossary/Readme'

module.exports =
  subscriptions: null
  
  activate: (state) ->
    @subscriptions = new CompositeDisposable()
    @subscriptions.add atom.commands.add 'atom-workspace', 'glossary-index:update': () => @update()

    _this = @
    @subscriptions.add atom.workspace.observeTextEditors (editor) ->
      if _this.isGlossary(editor) is true
        console.log "Tracking GLOSSARY file #{editor.getPath()}"
        _this.glossaries[editor.getPath()] = new Glossary(editor, _this.readmes[readme.getPath()])

      else if _this.isReadme(editor) is true
        console.log "Tracking README file #{editor.getPath()}"
        _this.readmes[editor.getPath()] = new Readme(editor)

    atom.project.getDirectories().forEach (d) -> _this.openTextEditor(d, (f) -> _this.isReadme(f))
    atom.project.getDirectories().forEach (d) -> _this.openTextEditor(d, (f) -> _this.isGlossary(f))

  deactivate: ->
    @subscriptions.dispose()

  update: ->
    if editor = atom.workspace.getActiveTextEditor()
      if @isGlossary(editor) is true
        @glossaries[editor.getPath()] = new Glossary(editor) if @glossaries[editor.getPath()] is undefined
        @glossaries[editor.getPath()].update()


  isGlossary: (fileOreditor) ->
    return fileOreditor.getPath().match(/^.*\/GLOSSARY\.md$/g)?

  isReadme: (fileOreditor) ->
    return fileOreditor.getPath().match(/^.*\/README\.md$/g)?

  openTextEditor: (file, filter = (f) -> true) ->
    if file.isSymbolicLink() or file.getBaseName().match /^\./ or file.getBaseName().match(/^templates$/)
      # NOP

    else if file.isDirectory()
      _this = @
      file.getEntriesSync().forEach (f) ->
        _this.openTextEditor(f, filter)

    else if filter(file)
      console.log "Opening TextEditor #{file.getPath()}"
      atom.open({pathsToOpen: [file.getPath()]})
