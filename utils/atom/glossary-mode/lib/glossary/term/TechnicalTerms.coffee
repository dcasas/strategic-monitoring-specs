Terms = require './Terms'

module.exports =
class TechnicalTerms extends Terms

  constructor: (@editor) ->
    super @editor, /#\s*Technical\s+Terms\s*?/i, /$/
