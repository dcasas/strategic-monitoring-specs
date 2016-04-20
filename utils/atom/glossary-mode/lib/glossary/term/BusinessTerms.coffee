Terms = require './Terms'

module.exports =
class BusinessTerms extends Terms

  constructor: (@editor) ->
    super @editor, /#\s*Business\s+Terms\s*?/i, /#\s*Technical\s+Terms\s*?/i
