#JIRA PRIMERO-337
#JIRA PRIMERO-736

@javascript @primero
Feature: Record Owner Form
  As a Social worker, I want to enter information related to the record owner

  Scenario: As a logged in user, I will enter information related to the record owner
    Given I am logged in as an admin with username "primero_mrm" and password "primero"
    When I access "incidents page"
    And I press the "New Incident" button
    And I press the "Record Owner" button
    And I fill in the following:
      | Field/Case/Social Worker | Social worker name    |
      | Caseworker Code          | <Select> Case Worker3 |
      | Agency                   | <Select> Agency1      |
      | Previous Owner           | Previous owner name   |
      | Previous Agency          | Previous agency name  |
    And I press "Save"
    Then I should see a success message for new Incident
    And I should see a value for "Field/Case/Social Worker" on the show page with the value of "Social worker name"
    And I should see a value for "Caseworker Code" on the show page with the value of "Case Worker3"
    And I should see a value for "Agency" on the show page with the value of "Agency1"
    And I should see a value for "Record created by" on the show page with the value of "primero_mrm"
    And I should see a value for "Previous Owner" on the show page with the value of "Previous owner name"
    And I should see a value for "Previous Agency" on the show page with the value of "Previous agency name"





