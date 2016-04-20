
IndexTable = require './IndexTable'
TermsLinks = require './TermsLinks'

module.exports =
class Readme

  constructor: (@editor) ->
    @index = new IndexTable(@editor)
    @links = new TermsLinks(@editor)

  # is ment to be used by the Glossary only. Only change sin the glossary will potentially change the readme file.
  update: (indexTable, termsLinks) ->
    console.log "Updating readme #{@editor.getPath()}"
    @index.update(indexTable, @index.getIndexTableRange())
