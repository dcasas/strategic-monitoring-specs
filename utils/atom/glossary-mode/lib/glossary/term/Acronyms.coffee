Terms = require './Terms'

module.exports =
class Acronyms extends Terms

  constructor: (@editor) ->
    super @editor, /#\s*Acronyms\s*/i, /#\s*Business\s+Terms\s*/i
