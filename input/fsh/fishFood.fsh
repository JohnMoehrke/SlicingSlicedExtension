


Extension: OtherId
Title: "AuditEvent.agent other identifiers"
Description: "Carries other identifiers that are known for an agent."
* ^context[+].type = #element
* ^context[=].expression = "AuditEvent.agent"
* value[x] only Identifier
* valueIdentifier 1..1


Extension: OtherIdName
Title: "AuditEvent.agent other identifiers name"
Description: "Extension to be used within otherId to carry the name of the identifier."
//* ^context[+].type = #element
//* ^context[=].expression = "Identifier"
* value[x] only string
* valueString 1..1


Profile: ThirdSliceProfile
Parent: AuditEvent
Title: "Slicing a Sliced Extension Profile"
Description: """
Profile showing problems with slicing a sliced extension
 
- adds an extension *otherId* on .agent
  - a slice on the *otherId* extension for *npi* and *prn*
  - adds an extension on the *prn* slice for *otherIdName*
- a slice on .agent for for *user*
- a slice on .agent for *userorg*
"""
* agent.extension contains OtherId named otherId 0..* MS
* agent ^slicing.discriminator.type = #pattern
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent contains user 1..*
* agent[user].type = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP
* agent[user].who 1..1 
* agent[user].purposeOfUse MS
* agent[user].media 0..0
/*
* agent contains userorg 0..*
* agent[userorg].type = http://terminology.hl7.org/CodeSystem/v3-RoleClass#PROV
* agent[userorg].who 1..1
* agent[userorg].purposeOfUse MS
* agent[userorg].media 0..0
*/

* agent[user].extension ^slicing.discriminator[1].type = #value
* agent[user].extension ^slicing.discriminator[=].path = "value.ofType(Identifier).type"
* agent[user].extension ^slicing.rules = #open
* agent[user].extension[otherId] contains npi 0..1 
* agent[user].extension[otherId][npi].valueIdentifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#NPI
* agent[user].extension[otherId] contains prn 0..1
* agent[user].extension[otherId][prn].valueIdentifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#PRN
* agent[user].extension[otherId][prn].valueIdentifier.extension contains OtherIdName named otherIdName 0..1 MS
* agent[user].extension[otherId][prn].valueIdentifier.extension[otherIdName] ^short = "name for this id"





Instance: ex-WithNpiPrn
InstanceOf: ThirdSliceProfile
Title: "Audit Example of third profile with validation error"
Description: """
Example causes validation to fail. [Zulip chat](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/slicing.20an.20extension.20on.20a.20slice)
"""
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* type = http://dicom.nema.org/resources/ontology/DCM#110100 "Application Activity"
* action = #R
* subtype = urn:ietf:rfc:1438#poke "Boredom poke"
* recorded = 2021-12-03T09:49:00.000Z
* outcome = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"
* source.site = "server.example.com"
* source.observer.display = "my server"
* source.type = http://terminology.hl7.org/CodeSystem/security-source-type#4 "Application Server"
* agent[user].type.coding = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP "information recipient"
* agent[user].who.identifier.value = "05086900124"
* agent[user].who.identifier.system = "https://sts.sykehuspartner.no"
* agent[user].requestor = true
* agent[user].extension[otherId][npi].valueIdentifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#NPI
* agent[user].extension[otherId][npi].valueIdentifier.value = "1234567@myNPIregistry.example.org"
* agent[user].extension[otherId][prn].valueIdentifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#PRN
* agent[user].extension[otherId][prn].valueIdentifier.value = "JohnD"


Instance: ex-WithNpiPrnName
InstanceOf: ThirdSliceProfile
Title: "Audit Example of third profile with validation error *"
Description: """
Example causes validation to fail. [Zulip chat](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/slicing.20an.20extension.20on.20a.20slice)

Note this also has the additional extension for *otherIdName*
"""
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* type = http://dicom.nema.org/resources/ontology/DCM#110100 "Application Activity"
* action = #R
* subtype = urn:ietf:rfc:1438#poke "Boredom poke"
* recorded = 2021-12-03T09:49:00.000Z
* outcome = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"
* source.site = "server.example.com"
* source.observer.display = "my server"
* source.type = http://terminology.hl7.org/CodeSystem/security-source-type#4 "Application Server"
* agent[user].type.coding = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP "information recipient"
* agent[user].who.identifier.value = "05086900124"
* agent[user].who.identifier.system = "https://sts.sykehuspartner.no"
* agent[user].requestor = true
* agent[user].extension[otherId][npi].valueIdentifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#NPI
* agent[user].extension[otherId][npi].valueIdentifier.value = "1234567@myNPIregistry.example.org"
* agent[user].extension[otherId][prn].valueIdentifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#PRN
* agent[user].extension[otherId][prn].valueIdentifier.value = "JohnD"
* agent[user].extension[otherId][prn].valueIdentifier.extension[otherIdName].valueString = "John D"


Instance: ex-WithoutUsingThirdSlice
InstanceOf: ThirdSliceProfile
Title: "Audit Example of third slice profile that does NOT have validation errors."
Description: """
Example causes validation to fail. [Zulip chat](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/slicing.20an.20extension.20on.20a.20slice)

This example does not have data in the third depth slice, so it does not throw a validation error.
"""
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* type = http://dicom.nema.org/resources/ontology/DCM#110100 "Application Activity"
* action = #R
* subtype = urn:ietf:rfc:1438#poke "Boredom poke"
* recorded = 2021-12-03T09:49:00.000Z
* outcome = http://terminology.hl7.org/CodeSystem/audit-event-outcome#0 "Success"
* source.site = "server.example.com"
* source.observer.display = "my server"
* source.type = http://terminology.hl7.org/CodeSystem/security-source-type#4 "Application Server"
* agent[user].type.coding = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP "information recipient"
* agent[user].who.identifier.value = "05086900124"
* agent[user].who.identifier.system = "https://sts.sykehuspartner.no"
* agent[user].requestor = true
* agent[user].extension[otherId].valueIdentifier.value = "Hello World"

/*
* agent[userorg].type = http://terminology.hl7.org/CodeSystem/v3-RoleClass#PROV "healthcare provider"
* agent[userorg].who.display = "St. Mary of Examples"
* agent[userorg].requestor = false
*/


Instance:   ex-patient
InstanceOf: Patient
Title:      "Dummy Patient example"
Description: "Dummy patient example for completeness sake. No actual use of this resource other than an example target"
Usage: #example
// history - http://playgroundjungle.com/2018/02/origins-of-john-jacob-jingleheimer-schmidt.html
* meta.security = http://terminology.hl7.org/CodeSystem/v3-ActReason#HTEST
* name[+].use = #usual
* name[=].family = "Schmidt"
* name[=].given = "John"
* name[+].use = #old
* name[=].family = "Schnidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingle"
* name[=].given[+] = "Heimer"
* name[=].period.end = "1960"
* name[+].use = #official
* name[=].family = "Schmidt"
* name[=].given[+] = "John"
* name[=].given[+] = "Jacob"
* name[=].given[+] = "Jingleheimer"
* name[=].period.start = "1960-01-01"
* name[+].use = #nickname
* name[=].family = "Schmidt"
* name[=].given = "Jack"
* gender = #other
* birthDate = "1923-07-25"
* address.state = "WI"
* address.country = "USA"


