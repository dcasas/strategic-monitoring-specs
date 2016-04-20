Feature: Some terse yet descriptive text of what is desired
         Textual description of the business value of this feature
         Business rules that govern the scope of the feature
         Any additional information that will make the feature easier to understand

   Background:
      Given there is a (DomainConcept1) "ref1"
        And the (DomainConcept1) "ref1" has {attributeName1} equals to "value1"
        And the (DomainConcept1) "ref1" has {attributeName2} equals to "value2"

   @critical # it means this is a candidate for automation. If this scenario does not work it means the feature is totally useless.
   Scenario: Some determinable business situation
      Given there is a (DomainConcept2) "ref2" with attributes
            | attrName1              | attrName2    | attrName3 |
            | <DomainConcept2.attr1> | [c1, c2, c3] | value3    |
        And there is a (User) "u" with (Role) "Enough Permissions"
       When the (User) "u" executes (ExampleCommand) "example" with attributes
            | otherAttrName1   | otherAttrName2 |
            | <Command1.attr1> | value2         |
       Then the (ExampleCommand) "example" outcome is "SUCCESS"
        And the (ExampleCommand) "example" result is equals to "ref1"

        Examples:
          | Command1.attr1 | DomainConcept2.attr1 |
          | xxxxx          |  yyyyyy              |
          | zzzzz          |  iiiiii              |

   Scenario:  ...
