<!-- TOC depthFrom:1 depthTo:6 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Introduction](#introduction)
- [Why I should care about this](#why-i-should-care-about-this)
- [Conventions And Organisation](#conventions-and-organisation)
	- [Glossary files](#glossary-files)
	- [Feature Files](#feature-files)
		- [SM flavored Gherkin Notation](#sm-flavored-gherkin-notation)
			- [`Given` Step Definition Conventions](#given-step-definition-conventions)
			- [`When` Step Definition Conventions](#when-step-definition-conventions)
			- [`Then` Step Definition Conventions](#then-step-definition-conventions)

<!-- /TOC -->

# Introduction
This is an attempt to define a [`DSL`] for [`SM`].

_"A domain model captures the most important types of objects in the context of the business. The domain model represents the ‘**things**’ that **exist** or **events** that transpire in the **business** environment."_ – I. Jacobsen

_"At its worst business logic can be very complex. Rules and logic describe many different cases and slants of behavior, and it's this complexity that **objects** were designed to work with. A Domain Model creates a web of **interconnected** objects, where each object represents some **meaningful** individual, whether as large as a corporation or as small as a single line on an order form"_ – Martin Fowler

The lack of a proper understanding of the domain hinders our ability to define useful specifications that are readily usable for assuring the quality of a software system (regardless whether those specifications are used for automated or manual testing).

The main goal of this project is to provide a conceptual framework of the _'things'_ in the [`SM`] space, based on _glossary of terms_ or _domain dictionaries_ among others, for helping you focus on semantics when defining and communicating specifications for new, or existing, functionalities so that such specifications can be used directly to asses the quality of [`SM`] system.

This repository is the _Single Source of Truth_ for [`SM`] _Domain Model_ and specifications, and, as a consequence, provides a static view of [`SM`]'s requirements (meaning it conveys time invariant business rules, which is the foundation for use case/workflow modelling).

# Why I should care about this
I will try to convince you that both _specifications_ and _working software_ are actually the same thing, and that it is worth spending a “reasonable” amount of time and effort on coming up with __good enough specifications__ in order to produce __working software__.

What it means “good enough specification"?

__A specification for a given [`Feature`] is good enough when you can directly use it to unambiguously verify the quality of a given implementation for such [`Feature`].__

… but equally important is to know exactly what “working software" means: is it enough if it compiles?... Well, definitely it is a prerequisite but we all know that is not enough. We can say that:

__Working Software for a given [`Feature`] accurately and unambiguously meets the [`Feature`]’s specifications__

I hope you all see the relationship between them and realise that you __can not__ have one without the other. One is the _Yin_, the other is the _Yang_, they are inseparable.

We tend to think that they are different due to the division of labour (different people/skills) required to produce software systems but, actually, the main difference is that we use [Natual Language]s to define specifications and [Programming Language]s to produce “working” (or maybe not) software — which is a consequence of the division of labour itself —. But [Natual Language]s are really bad as [Specification Language]s (which you probably know already), and this is the reason behind one of the [Manifesto for Agile Software Development] principles: __Working software over comprehensive documentation__. This principle recognises that there is no such thing as perfect specifications, neither perfect software systems. It does not remove the need for specifications, but It recognises that it is pointless to spend too much time/effort on producing specifications that do not accurately and unambiguously defines the behaviour of a given [`Feature`]. It is better to produce _working software_ that can be used to refine or verify its own specifications. But at the same time it is pointless to spend too much time on producing _working software_ that solves a problem we don't have.

Both documentation/specifications and working software evolve hand by hand, and it is our duty as professional software engineers to ensure both are in sync:
* The specifications accurately and unambiguously defines what the software system/code does, so non technical people can understand what the system actually does.
* The software system/code actually does what the specifications define, so technical people can maintain the system while meeting the actual needs of its users.

__Good enough specifications significantly reduces the maintainability effort/cost of a software system as the technological and business requirements evolve over time__ (_I claim this as a fact, although it is purely based on my experience_).

This is the reason why spending more time/effort on defining specifications more formally would help us producing working software by increasing efficiency in the way we actually produce it.

# Conventions And Organisation
The information in this repository is organized into folders, which represent [`SM`]'s _subdomains_, and each folder/subdomain contains the _dictionaries/glossaries_ and _features_ files. The folder structure could be arbitrary deep, as long as it make sense to break down a particular (sub)domain into other (sub)domains we can create a many as we need. Each (sub)domain should be simple enough, all its terms should have a high cohesion (they should be related to each other) and low coupling with other (sub)domains' terms (they should be as independent from other domain's terms as possible).

```
some-domain
   |- README.md                          # High level description of this domain
   |- GLOSSARY.md                        # Global Acronyms & Terms definitions for this domain
   |- DSL.md                             # DSL documentation
   |- templates                          # Template files for new domains
   |   |- README.md
   |   |- GLOSSARY.md
   |   |- feature
   |       |- command
   |       |    |- Command.feature
   |       |- query
   |            |- Query.feature
   |- SubDomain1
   |      |- README.md                   # High level description of this domain
   |      |- GLOSSARY.md                 # Specific Acronyms & Terms definitions for SubDomain1 domain
   |      |- feature                     # Folder containing all the features for this domain
   |           |- command                # Contains all the features that change the state of the system (Write Operations)
   |           |    |- Command1.feature  # Scenarios for the feature "Command1"
   |           |    |- Command2.feature
   |           |- query                  # Contains all the features that retrieve the state of the system (Read operations)
   |                |- Query1.feature    # Scenarios for the feature "Query1"
   |                |- ...
   |- SubDomain2
   |      |- README.md                   # High level description of the current subdomain
   |      |- GLOSSARY.md                 # Specific Acronyms & Terms definitions for SubDomain2 domain
   |      |- SubSubDomain2.1
   |      |    |- GLOSSARY.md            # Specific Acronyms & Terms definitions for SubDomain2.1 domain
   |      |    |- features
   |      |         |- ...
   |      |- SubSubDomain2.2
   |...
```

## Glossary files
Every (sub)domain should contain a `GLOSSARY.md` file which contains all the relevant acronyms and terms for such domain. The glossary file is in [MarkDown] and use this [GLOSSARY.md](utils/templates/GLOSSARY.md) as template.

Every term should have:

* a concise _description_
* an exhaustive list of all the attributes, both mandatory and optional, the term owns. And each attribute should have:
	* a concise _description_
	* a specific _type_ (which must be a term in the glossary). The type restricts the possible values the attribute may have.
	* a _default value_ in case of optional attributes.
	* an _example value_ showing typical valid or invalid values.
	* a exhaustive list of _validation rules_
* an exhaustive list of all the messages (typically error meesages) the term owns. Those messages are the ones that usually are sent back to the [`Actor`] after executing a [`Command`] or [`Query`].

## Feature Files
A [`Feature`] is a distinctive aspect of a `Story`. A `Story` can and should be broken down into features, where each feature is the smallest indivisible behavior that an [`Actor`] of the system can perform. There are two types of features or behaviors, as described by the [Command And Query Separation] principle: _commands_ and _queries_.
* [`Command`]: A _Command_ performs an action on the system and it **changes** its state
* [`Query`]: A _Query_ retrieves information from the system and it does **not** change its state

For each [`Feature`] in a _story_ there will be a feature file, as described in the [Conventions](#conventions) section. The feature file contains the feature's [Behavioral Specifications] using [Gherkin Notation].

### SM flavored Gherkin Notation
The [Gherkin Notation], on its own, does not help us to reduce the gap, impedance mismatch or translation cost between the business requirements and the tests that assure the quality of a particular technical solution due. Additionally we need to define a [`DSL`], a common language that both the business and technical people understand. Basically we would need to:
* make explicit references to the domain concepts used in each step definition, and those domain concepts must be univocally identified in the domain dictionary/glossary.
* make the steps definitions as simple and short as possible. They should do _one and only one thing_, they should reference one and only one domain concept.
* make the steps definition standard by defining well known patterns for the _Given_, _When_ and _Then_ steps.
* encourage reusability of step definitions
* encourage composability of step definitions

Here is an example of a feature file:
```gherkin
Feature: Some terse yet descriptive text of what is desired
         Textual description of the business value of this feature
         Business rules that govern the scope of the feature
         Any additional information that will make the feature easier to understand

   Background:
      Given there is a (DomainConcept1) "ref1"
        And the (DomainConcept1) "ref1" has {attributeName1} equals to "value1"
        And the (DomainConcept1) "ref1" has {attributeName2} equals to "value2"

   @critical
   Scenario: Some determinable business situation
      Given there is a (DomainConcept2) "ref2" with attributes
            | attr1                  | attr2        | attr3  |
            | <DomainConcept2.attr1> | [c1, c2, c3] | value3 |
        And there is a (User) "u" with (Role) "Enough Permissions"
       When the (User) "u" executes (CommandOrQuery1) "command1" with attributes
            | attr1            | attr2  |
            | <Command1.attr1> | value2 |
       Then the (CommandOrQuery1) "command1" state is "SUCCESSFUL"
        And the (CommandOrQuery1) "command1" result is equals to "ref1"

        Examples:
          | Command1.attr1 | DomainConcept2.attr1 |
          | xxxxx          |  yyyyyy              |
          | zzzzz          |  iiiiii              |

   Scenario:  ...
```

Where:
* `... (DomainConcept) ...` is a reference to a domain concept in the domain dictionary
* `... (DomainConcept) "ref" ...` is a concrete reference to an instance of a domain concept with name `ref`
* `... {attributeName} ...` is a reference to an attribute of a domain concept
* `... <label> ... ` is a reference to an example (see [Scenario Outlines](https://github.com/cucumber/cucumber/wiki/Scenario-Outlines))

Find in the [templates](utils/templates) folder more examples.

#### `Given` Step Definition Conventions
The purpose of `Given` steps is to put the system in a known state before the user starts interacting with the system (in the When steps).

Use one of these patterns when writing `Given` step definitions:
```gherkin
   # Reference to a domain concept with default values for its attributes
   Given there is a (DomainConcept) "ref"

   #Reference to a domain concept with specific value for one of its simple attributes (strings, numbers, ...)
   Given there is a (DomainConcept) "ref" with {attributeName} equals to 'value'

   #Reference to a domain concept with specific value for one of its complex attribute (if a collection, just declare multiple rows)
   Given there is a (DomainConcept) "ref" with {attributeName} equals to
         | attrName1 | attrName2    | attrName3 | ... |
         | value1    | [c1, c2, c3] | value3    | ... |
         | value2    | [c4, c1, c3] | value2    | ... |

   Given there is a (DomainConcept) "ref" with {attributeName} equals to (DomainConcept1) "ref1"
   Given there is a (DomainConcept) "ref" with {attributeName} equals to [ (DomainConcept1) "ref1", (DomainConcept1) "ref2", .. ]

   # Reference to a domain concept with specific values for its attributes
   Given there is a (DomainConcept) "ref" with attributes
         | attrName1 | attrName2    | attrName3 | ... |
         | value1    | [c1, c2, c3] | value3    | ... |

   # Reference to a collection of domain concepts with specific values for their attributes
   Given there are (DomainConcept)s
         | Reference | attrName1 | attrName2       | attrName3 |
         | ref1      | x1        | [xc1, xc2, xc3] | x3        |
         | ref2      | y1        | [yc1, yc2, yc3] | y3        |
         | ref3      | z1        | [zc1, zc2, zc3] | z3        |

   # And the variant for instances created in other step definitions
   Given the (DomainConcept) "ref" has {attributeName} ...
```
#### `When` Step Definition Conventions
The purpose of `When` steps is to describe the key action an [`Actor`] performs against the system. As mentioned, there are only two things an [`Actor`] can do, execute a [`Command`] or a [`Query`].

Use one of these patterns when writing `When` step definitions:
```gherkin
   # Executing a command or query with default values for its attributes
   When the (Actor) "a" executes (CommandOrQuery) "coq"

   # Executing a command or query with specific values for its attributes
   When the (Actor) "a" executes (CommandOrQuery) "coq" with attributes
            | CommandOrQuery1.attr1 | CommandOrQuery1.attr2 |
            | <Command1.attr1>      | value2                |

   # Executing a command or query with a reference to a domain concept as its only argument
   When the (Actor) "a" executes (CommandOrQuery) "coq" with (DomainConcept) "ref"
```

OBS: Notice that a [`Command`] or [`Query`] is executed by someone, an [`Actor`], hence a specific [`Actor`] with specific permissions must be defined as a `Given`.

#### `Then` Step Definition Conventions
The purpose of `Then` steps is to observe outcomes of the commands or queries.

Use one of these patterns when writing `Then` step definitions:
```gherkin
   # Asserting whether the command or query was executed successfully
   Then the (CommandOrQuery) "coq" outcome is "SUCCESS"
   Then the (CommandOrQuery) "coq" outcome is "FAILURE"

   # Asserting whether the command or query has failed with a given reason
   Then the (CommandOrQuery) "coq" outcome message is "Failed for this Reason"
   Then the (CommandOrQuery) "coq" outcome message is not "Failed for this Reason"
   Then the (CommandOrQuery) "coq" outcome message matches "Regular Expression"
   Then the (CommandOrQuery) "coq" outcome message does not match "Regular Expression"

   # Asserting whether the command or query result is equals to a given reference
   Then the (CommandOrQuery) "coq" result is equals to (DomainConcept) "ref"
   Then the (CommandOrQuery) "coq" result is not equals to (DomainConcept) "ref"

   # Asserting whether the command or query result has an attribute that meets a given criteria
   Then the (CommandOrQuery) "coq" result's {attributeName} is equals to "value"
   Then the (CommandOrQuery) "coq" result's {attributeName} is not equal to "value"
   Then the (CommandOrQuery) "coq" result's {attributeName} contains "value"
   Then the (CommandOrQuery) "coq" result's {attributeName} does not contain "value"
   Then the (CommandOrQuery) "coq" result's {attributeName} matches "Regular Expression"
   Then the (CommandOrQuery) "coq" result's {attributeName} does not match "Regular Expression"
   Then the (CommandOrQuery) "coq" result's {attributeName} is greater than "value"
   Then the (CommandOrQuery) "coq" result's {attributeName} is greater than or equals to "value"
   Then the (CommandOrQuery) "coq" result's {attributeName} is less than "value"
   Then the (CommandOrQuery) "coq" result's {attributeName} is less than or equals to "value"
```

[`SM`]:      GLOSSARY.md#sm     "Strategic Monitoring"
[`DSL`]:     GLOSSARY.md#dsl     "DSL"
[`Actor`]:   GLOSSARY.md#actor   "Actor"
[`Query`]:   GLOSSARY.md#query   "Feature"
[`Feature`]: GLOSSARY.md#feature "Feature"
[`Command`]: GLOSSARY.md#command "Feature"
[MarkDown]: https://help.github.com/articles/github-flavored-markdown/ "Github Flavored MarkDown"
[Gherkin Notation]: https://github.com/cucumber/cucumber/wiki/Gherkin "Gherkin Notation"
[Behavioral Specifications]: https://en.wikipedia.org/wiki/Behavior-driven_development#Behavioural_specifications "Behavioral Specifications"
[Command And Query Separation]: http://martinfowler.com/bliki/CommandQuerySeparation.html "Command And Query Separation"
[Natual Language]: https://en.wikipedia.org/wiki/Natural_language "Natural Language"
[Programming Language]: https://en.wikipedia.org/wiki/Programming_language "Programming Language"
[Specification Language]: https://en.wikipedia.org/wiki/Specification_language "Specification Language"
[Manifesto for Agile Software Development]: http://agilemanifesto.org/ "Manifesto for Agile Software Development"
