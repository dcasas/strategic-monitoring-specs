<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Example Domain](#example-domain)
- [Glossary](#glossary)
- [Meet the Domain Experts](#meet-the-domain-experts)
- [Features](#features)
		- [Command Features](#command-features)
		- [Query Features](#query-features)

<!-- /TOC -->

# Example Domain
_This provides a high level description of the `Example` domain. This is the entry point to anyone interested on learning about the `Example` domain, so this file should contain any relevant information  that helps anyone to get a good idea what this is about._

_Optionally use graphs and links to external documents._

![WCO Domain](http://g.gravizo.com/g?
  digraph G {
      Domain -> {SubDomain1 SubDomain2}
      Domain [shape=box]
      SubDomain1 [color=red]
      SubDomain2 [color=orange]
  }
)

# Glossary
_This is a mandatory section and it should provide at least a link to the glossary file fo this domain. See [DSL's Glossary Section](../DSL.md#glossary-files) for more details._

See [GLOSSARY](GLOSSARY.md)

# Meet the Domain Experts
_This section is optional, and only required if this domain is broken down into subdomains. List all subdomains and nominate and owner/expert who would be responsible of maintaining this domain. For example:_

| Subdomain    | Expert      |
|--------------|-------------|
| [SubDomain1] | ![INeedYou] |
| [SubDomain2] | ![INeedYou] |

[SubDomain1]: SubDomain1/README.md "Sub Domain 1"
[SubDomain2]: SubDomain2/README.md "Sub Domain 1"
[INeedYou]: http://www.beavercreek.k12.oh.us/cms/lib5/OH01000456/Centricity/Domain/30/landmarks_symbols/images/uncle_sam1.png "I Need You"

# Features
_This section is optional, and only required if this domain is **NOT** broken down into subdomains. The actual list of features can be generated using following script [generateFeatureList](../utils/generateFeatureList.sh). See [DSL's features Section](../DSL.md#feature-files) for more details._

### Command Features
 * [`ExampleCommand`](feature/command/ExampleCommand.feature):  Some terse yet descriptive text of what is desired. Textual description of the business value of this feature. Business rules that govern the scope of the feature. Any additional information that will make the feature easier to understand.

### Query Features
 * [`ExampleQuery`](feature/query/ExampleQuery.feature):  Some terse yet descriptive text of what is desired. Textual description of the business value of this feature. Business rules that govern the scope of the feature. Any additional information that will make the feature easier to understand
