
Feature: CreateIssue Command
  As an (User) of Strategic Monitoring Issue Management
  I want to create an (Issue)
  So that I have a durable record of the problem/issue in the (StudyConduct)

  Background:
    Given there is a (Sponsor) "Infinity"
      And there is a (Customer) "CellTrion"
      And there is a (Site) "London Hospital"
      And there is a (Study) "SuperSecret-XXX-YYYY"
      And the (Study) "SuperSecret-XXX-YYYY" has {owner} equals to (Customer) "CellTrion"

      And there is a (User) "Chirag"   with {role} equals to (Role) "Clinical Research Associate"
      And there is a (User) "Cecilia"  with {role} equals to (Role) "Central Monitor"
      And there is a (User) "Stanley"  with {role} equals to (Role) "Statistical Monitor"
      And there is a (User) "Stuart"   with {role} equals to (Role) "Study Manager "
      And there is a (User) "Victoria" with {role} equals to (Role) "VP Clinical Operations"
      And there is a (User) "Dana"     with {role} equals to (Role) "Data Manager"
      And there is a (User) "Stuart"   with {role} equals to (Role) "Study Manager "
      And there is a (User) "Carmen"   with {role} equals to (Role) "Lead CRA"
      And there is a (User) "Spencer"  with {role} equals to (Role) "Contract CRA"
      And there is a (User) "Ana"      with {role} equals to (Role) "CTA"
      And there is a (User) "Mateus"   with {role} equals to (Role) "PM"
      And there is a (User) "Keimi"    with {role} equals to (Role) "Programme Director"

      And the (User) "Chirag"   has {owner} equals to (Customer) "CellTrion"
      And the (User) "Cecilia"  has {owner} equals to (Customer) "CellTrion"
      And the (User) "Stanley"  has {owner} equals to (Customer) "CellTrion"
      And the (User) "Stuart"   has {owner} equals to (Customer) "CellTrion"
      And the (User) "Victoria" has {owner} equals to (Customer) "Infinity"
      And the (User) "Dana"     has {owner} equals to (Customer) "CellTrion"
      And the (User) "Stuart"   has {owner} equals to (Customer) "CellTrion"
      And the (User) "Carmen"   has {owner} equals to (Sponsor)  "Infinity"
      And the (User) "Spencer"  has {owner} equals to (Customer) "CellTrion"
      And the (User) "Ana"      has {owner} equals to (Site)     "London Hospital"
      And the (User) "Mateus"   has {owner} equals to (Sponsor)  "Infinity"
      And the (User) "Keimi"    has {owner} equals to (Customer) "CellTrion"

  @critical
  Scenario: User should be able to create an issue
     When the (User) "<PERSONA>" executes the (CreateIssue) "command" with attributes
          | title  | description | category | classification | severity | level |
          | ValTit |  ValidDesc  | ValidCat |   ValidClass   | ValidSev |<LEVEL>|
     Then the (CreateIssue) "command" outcome is "SUCCESS"
      And the (CreateIssue) "command" result's {id} matches "^[A-Z]{3}-\d{1,10}$"
    Examples:
        | PERSONA | LEVEL             |
        | Chirag  | Client Division   |
        | Chirag  | Study-Environment |
        | Chirag  | Client Division   |
        | Cecilia |  ....             |
        | Stuart  |  ....             |
        | Keimi   |  ....             |
        |  ....   |  ....             |
