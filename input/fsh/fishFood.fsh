
Profile:        FirstProfile
Parent:         AuditEvent
Title:          "FirstProfile just adds an otherId extension, and slices .agent[user]."
Description:    """
Simple slice of the .agent
"""
* agent.extension contains OtherId named otherId 0..* MS
* agent ^slicing.discriminator.type = #pattern
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent contains 
    user 1..
* agent[user].type = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP "information recipient"
* agent[user].who 1..1 




Profile:        SecondProfile
Parent:         FirstProfile
Title:          "Second Profile builds on First Profile and further slices"
Description:    """
add slices to otherId
"""

* agent[user].extension[otherId] ^slicing.discriminator.type = #pattern
* agent[user].extension[otherId] ^slicing.discriminator.path = "(value as Reference).identifier.type"
* agent[user].extension[otherId] ^slicing.rules = #open
* agent[user].extension[otherId] contains 
	npi 0..1 and
	provider-id 0..1
* agent[user].extension[otherId][npi].valueReference.identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#NPI
* agent[user].extension[otherId][provider-id].valueReference.identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#PRN



Instance: ex-SecondProfile
InstanceOf: SecondProfile
Title: "Audit Example of second profile to show the build validation error"
Description: """
Example causes validation to fail. [Zulip chat](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/slicing.20an.20extension.20on.20a.20slice)
"""
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* type = DCM#110100 "Application Activity"
* action = #R
* subtype = urn:ietf:rfc:1438#poke "Boredom poke"
* recorded = 2021-12-03T09:49:00.000Z
* outcome = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"
* source.site = "server.example.com"
* source.observer = Reference(Device/ex-device)
* source.type = http://terminology.hl7.org/CodeSystem/security-source-type#4 "Application Server"
* agent[user].type.coding = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP "information recipient"
* agent[user].who.identifier.value = "05086900124"
* agent[user].who.identifier.system = "https://sts.sykehuspartner.no"
* agent[user].extension[otherId][npi].valueReference.identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#NPI
* agent[user].extension[otherId][npi].valueReference.identifier.value = "1234567@myNPIregistry.example.org"
* agent[user].extension[otherId][provider-id].valueReference.identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#PRN
* agent[user].extension[otherId][provider-id].valueReference.identifier.value = "JohnD"







Extension: OtherId
Id: ihe-otherId
Title: "AuditEvent.agent other identifiers"
Description: "Carries other identifiers are known for an agent."
* value[x] only Reference

CodeSystem: UserAgentTypes
Title: "The code used to identifiy a User Agent"
Description: """
Code used to identify the User Agent.
Defined codes for SAML vs OAuth to enable differentiation of .policy as the token ID
"""
* ^caseSensitive = false
* #UserSamlAgent "User SAML Agent participant"
* #UserOauthAgent "User OAuth Agent participant"

ValueSet: UserAgentTypesVS
Title: "Agent types holding User-Agent"
Description: """
AuditEvent.agent.type values holding OAuth/SAML identified user. Note that user is not just humans, but representes the higest agent responsible for triggering the activity being recorded in the AuditEvent.

Often this agent also has a type coding that is more specific to the transaction and the direction of the transaction.
- http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP // use for query/retrieve
- http://terminology.hl7.org/CodeSystem/v3-RoleClass#AGNT // use for push/create/update
- http://terminology.hl7.org/CodeSystem/v3-RoleClass#PAT  // use when the user is the patient
- http://terminology.hl7.org/CodeSystem/v3-ParticipationType#AUT "Author" // used with create/update
- http://terminology.hl7.org/CodeSystem/v3-ParticipationType#INF "Informant" // used with export
- http://terminology.hl7.org/CodeSystem/v3-ParticipationType#CST "Custodian" // used with export
"""
* UserAgentTypes#UserSamlAgent
* UserAgentTypes#UserOauthAgent


