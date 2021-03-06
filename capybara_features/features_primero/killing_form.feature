#JIRA PRIMERO-296
#JIRA PRIMERO-324
#JIRA PRIMERO-352
#JIRA PRIMERO-363
#JIRA PRIMERO-373
#JIRA PRIMERO-365
#JIRA PRIMERO-244
#JIRA PRIMERO-283
#JIRA PRIMERO-526
#JIRA PRIMERO-736

@javascript @primero
Feature: Killing Form
  As a User, I want to capture the weapon type for killing or maiming violations so that information is recorded for reporting purposes

  Background:
    Given I am logged in as an admin with username "primero_mrm" and password "primero"
    When I access "incidents page"
    And I press the "New Incident" button
    And I press the "Incident" button
    And I choose from "Violation Category":
     | Killing of Children |
    And I press the "Violations" button
    And I press the "Killing" button

  Scenario: As a logged in user, I will create a incident for killing of children
    And I fill in the following:
      | Number of victims                                                                  | <Tally>Boys:1<Tally>Girls:2<Tally>Unknown:3  |
      | Method                                                                             | <Select> Summary                             |
      | Cause                                                                              | <Select> IED                                 |
      | Details                                                                            | Some details                                 |
      | Circumstances                                                                      | <Select> Direct Attack                       |
      | Consequences                                                                       | <Choose>Killing                              |
      | Context                                                                            | <Select> Weapon Used Against The Child       |
      | Mine Incident                                                                      | <Radio> No                                   |
      | Was the victim directly participating in hostilities at the time of the violation? | <Select> Yes                                 |
      | Did the violation occur during or as a direct result of abduction?                 | <Select> Yes                                 |
      | Verifier                                                                                                                        | primero_mrm                                                             |
      | Verification Decision Date                                                                                                      | today's date                                                            |
      | Has the information been received from a primary and reliable source?                                                           | <Select> Yes, from a credible Primary Source who witnessed the incident |
      | Was the incident witnessed by UN staff or other MRM-trained affiliates?                                                         | <Radio> Yes                                                             |
      | Is the information consistent across various independent sources?                                                               | <Radio> Yes                                                             |
      | Has the veracity of the allegations been deemed credible using reasonable and sound judgement of trained and reliable monitors? | <Radio> No                                                              |
      | If not verified, why?                                                                                                           | <Select> Other                                                          |
      | Notes on Verification Decision                                                                                                  | Notes                                                                   |
      | Verified by CTFMR                                                                                                               | <Radio> No                                                              |
      | Date verified by CTFMR                                                                                                          | today's date                                                            |
    #TODO - fix
    #And the value of "Number of total victims" in the 1st "Killing" subform should be "6"
    And I press "Save"
    Then I should see a success message for new Incident
    And I should see 1 subform on the show page for "Killing"
    And I should see in the 1st "Killing" subform with the follow:
      | Number of victims                                                                  |<Tally> Boys:1 Girls:2 Unknown:3 Total number of victims:6 |
      | Method                                                                             | Summary                       |
      | Cause                                                                              | IED                           |
      | Details                                                                            | Some details                  |
      | Circumstances                                                                      | Direct Attack                 |
      | Consequences                                                                       | Killing                       |
      | Context                                                                            | Weapon Used Against The Child |
      | Mine Incident                                                                      | No                            |
      | Was the victim directly participating in hostilities at the time of the violation? | Yes                           |
      | Did the violation occur during or as a direct result of abduction?                 | Yes                           |
      | Verifier                                                                                                                        | primero_mrm                                                    |
      # | Verification Decision Date                                                                                                      | today's date                                                   |
      | Verification Status                                                                                                             | Pending Verification                                                        |
      | Has the information been received from a primary and reliable source?                                                           | Yes, from a credible Primary Source who witnessed the incident |
      | Was the incident witnessed by UN staff or other MRM-trained affiliates?                                                         | Yes                                                            |
      | Is the information consistent across various independent sources?                                                               | Yes                                                            |
      | Has the veracity of the allegations been deemed credible using reasonable and sound judgement of trained and reliable monitors? | No                                                             |
      | If not verified, why?                                                                                                           | Other                                                          |
      | Notes on Verification Decision                                                                                                  | Notes                                                          |
      | Verified by CTFMR                                                                                                               | No                                                             |
      # | Date verified by CTFMR                                                                                                          | today's date                                                   |

   Scenario: As a logged in user and create an incident with invalid numeric values, I should see the error messages invalid number
     And I fill in the following:
      | Number of victims | <Tally>Boys:1<Tally>Girls:2<Tally>Unknown:BadNumber |
     And I press "Save"
     And I should see 1 subform on the show page for "Killing"
     And I should see in the 1st "Killing" subform with the follow:
      | Number of victims |<Tally> Boys:1 Girls:2 Unknown: Total number of victims:3 |
