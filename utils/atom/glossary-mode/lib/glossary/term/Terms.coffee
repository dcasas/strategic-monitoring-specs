fs = require 'fs'
{File, TextEditor} = require 'atom'

module.exports =
class Terms

  constructor: (@editor, @fromPattern, @toPattern) ->
    @file = @editor.getPath()

    if @editor instanceof TextEditor
      _this = @
      @editor.getBuffer().onWillSave () -> _this.reload()

    @terms = []

  reload: () ->
    console.log "Reloading #{@constructor.name} for glossary #{@file}"
    @text = fs.readFileSync(@file, 'utf8')
    from  = @text.search @fromPattern
    to    = @text.search @toPattern
    @text = @text.substring(from, to)

    # Every Term is defined on their own mardown section level 3 (== ###) and the term name will always follow UpperCamelCase style (so no spaces in names)
    @terms      = @text.split('\n').filter( (line) -> line.match /^###\s+([^\s]+)\s*/).map( (line) -> line.match(/^###\s+([^\s]+)\s*/)[1] )
    @references = @terms.map (t) -> Terms.getReference t

    return @

  ## TODO: all below methods should be class members/static but _getAllGlossaries needs to instantiate specific Terms
  ## so we need to provide an extension mechanism to allow it transparently

  getAllReferences: () ->
    return [].concat.apply([], @_getAllGlossaries().map (T) -> T.references)

  @getReference: (term) ->
    return "[`#{term}`]"

  # returns all terms links (relative to the current Glossary) from all available glossaries.
  getAllTerms: () ->
    return [].concat.apply([], @_getAllGlossaries().map (T) -> T.terms)

  # returns all terms links (relative to the current Glossary) from all available glossaries.
  getAllTermsLinks: () ->
    _this = @
    return [].concat.apply([], @_getAllGlossaries().map (T) -> _this._getTermsLinks(T, _this))

  # returns the given glossary's terms links relative to the given fromGlossary
  _getTermsLinks: (glossary, fromGlossary) ->
    from    = new File(fromGlossary.editor.getPath(), false).getParent()
    to      = new File(glossary.editor.getPath(), false)
    relPath = @_getRelPath(from, to)
    return glossary.terms.map (t) -> "[`#{t}`]: #{relPath}\##{t.toLowerCase()} \"#{t}\""

  _getRelPath: (from, to) ->
    if to.getPath().search(from.getPath()) > -1
      return to.getPath().replace "#{from.getPath()}/", ""

    else
      return "../" + @_getRelPath(from.getParent(), to)

  _getAllGlossaries: (file = atom.project.getDirectories()[0]) ->
    if file.isDirectory()
      _this = @
      return [].concat.apply([], file.getEntriesSync().map((f) -> _this._getAllGlossaries f))

    else if file.getPath().match(/GLOSSARY\.md$/) and not file.getPath().match(/templates/)
      console.log "reading file #{file.getPath()}"
      return [ new Terms(new File(file.getPath(), false), @fromPattern, @toPattern).reload() ]

    else
      return []
