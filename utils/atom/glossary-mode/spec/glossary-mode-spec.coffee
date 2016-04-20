describe "Glossary Grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage('glossary-mode')

    runs ->
      grammar = atom.grammars.grammarForScopeName("source.glossary")

  it "parses the grammar", ->
    expect(grammar).toBeDefined()
    expect(grammar.scopeName).toBe "source.glossary"

  it "tokenizes index table comment", ->
    [_1stLineTokens, _2ndLineTokens, _3rdLineTokens] = grammar.tokenizeLines(
        """
        <!-- GLOSSARY:Index global='true' option = "value" -->
        anything
        <!-- /GLOSSARY:Index -->
        """
    )

    expect(_1stLineTokens[0]).toEqual value: "<!-- GLOSSARY:Index ", scopes: ["source.glossary", "glossary.index"]
    expect(_1stLineTokens[1]).toEqual value: "global",   scopes: ["source.glossary", "glossary.index", "glossary.index.option", "glossary.index.option.name"]
    expect(_1stLineTokens[2]).toEqual value: "='",       scopes: ["source.glossary", "glossary.index", "glossary.index.option"]
    expect(_1stLineTokens[3]).toEqual value: "true",     scopes: ["source.glossary", "glossary.index", "glossary.index.option", "glossary.index.option.value"]
    expect(_1stLineTokens[4]).toEqual value: "' ",       scopes: ["source.glossary", "glossary.index", "glossary.index.option"]
    expect(_1stLineTokens[5]).toEqual value: "option",   scopes: ["source.glossary", "glossary.index", "glossary.index.option", "glossary.index.option.name"]
    expect(_1stLineTokens[6]).toEqual value: " = \"",    scopes: ["source.glossary", "glossary.index", "glossary.index.option"]
    expect(_1stLineTokens[7]).toEqual value: "value",    scopes: ["source.glossary", "glossary.index", "glossary.index.option", "glossary.index.option.value"]
    expect(_1stLineTokens[8]).toEqual value: "\" ",      scopes: ["source.glossary", "glossary.index", "glossary.index.option"]
    expect(_1stLineTokens[9]).toEqual value: "-->",      scopes: ["source.glossary", "glossary.index"]
    expect(_2ndLineTokens[0]).toEqual value: "anything", scopes: ["source.glossary", "glossary.index", "glossary.text"]
    expect(_3rdLineTokens[0]).toEqual value: "<!-- /GLOSSARY:Index -->", scopes: ["source.glossary", "glossary.index"]

  it "tokenizes Acronyms", ->
    [_1stLineTokens, _2ndLineTokens, _3rdLineTokens, _4thLineTokens, _5thLineTokens, _6thLineTokens, _7thLineTokens] = grammar.tokenizeLines(
        """
        # Acronyms
        anything
        ### ABC
        something
        ### CDE
        else
        # Business Terms
        """
    )

    expect(_1stLineTokens[0]).toEqual value: "# Acronyms", scopes: ["source.glossary", "glossary.acronyms"]
    expect(_2ndLineTokens[0]).toEqual value: "anything",   scopes: ["source.glossary", "glossary.acronyms", "glossary.text"]
    expect(_3rdLineTokens[0]).toEqual value: "### ",       scopes: ["source.glossary", "glossary.acronyms", "glossary.term"]
    expect(_3rdLineTokens[1]).toEqual value: "ABC",        scopes: ["source.glossary", "glossary.acronyms", "glossary.term", "glossary.term.name"]
    expect(_4thLineTokens[0]).toEqual value: "something",  scopes: ["source.glossary", "glossary.acronyms", "glossary.term", "glossary.text"]
    expect(_5thLineTokens[0]).toEqual value: "### ",       scopes: ["source.glossary", "glossary.acronyms", "glossary.term"]
    expect(_5thLineTokens[1]).toEqual value: "CDE",        scopes: ["source.glossary", "glossary.acronyms", "glossary.term", "glossary.term.name"]
    expect(_6thLineTokens[0]).toEqual value: "else",       scopes: ["source.glossary", "glossary.acronyms", "glossary.term", "glossary.term.text"]
