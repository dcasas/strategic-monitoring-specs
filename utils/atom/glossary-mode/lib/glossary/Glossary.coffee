IndexTable = require './IndexTable'
TermsLinks = require './TermsLinks'

module.exports =
class Glossary

  constructor: (@editor, @readme) ->
    @index = new IndexTable(@editor)
    @links = new TermsLinks(@editor)

    _this = @
    @editor.getBuffer().onWillSave () ->
      _this.update()

  update: ->
    console.log "Updating #{@constructor.name} #{@editor.getPath()}"
    @index.update()
    @links.update()
    @readme?.update(@index.generateIndexTable(), @links.generateReferences())
