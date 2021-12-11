


Extension: OtherId
Title: "AuditEvent.agent other identifiers"
Description: "Carries other identifiers that are known for an agent."
* value[x] only Reference


Profile: FirstSliceProfile
Parent: AuditEvent
Title: "Profile defines one slice on .agent for user"
Description: """
Simple profile to set the stage
"""
* agent.extension contains OtherId named otherId 0..* MS
* agent ^slicing.discriminator.type = #pattern
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent contains 
    user 1..
* agent[user].type = http://terminology.hl7.org/CodeSystem/v3-ParticipationType#IRCP "information recipient"
* agent[user].who 1..1 





Profile:        SecondSliceProfile
Parent:         FirstSliceProfile
Title:          "Profile with slices of extension in a slice"
Description:    """
based on FirstSliceProfile where [user] is defined
- slices .agent extension otherId
"""
* agent[user].extension[otherId] ^slicing.discriminator.type = #pattern
* agent[user].extension[otherId] ^slicing.discriminator.path = "$this.value.ofType(Reference).identifier.type"
* agent[user].extension[otherId] ^slicing.rules = #open
* agent[user].extension[otherId] contains 
	npi 0..1 and
	provider-id 0..1
* agent[user].extension[otherId][npi].valueReference.identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#NPI
* agent[user].extension[otherId][provider-id].valueReference.identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#PRN



Profile: ThirdSliceProfile
Parent: SecondSliceProfile
Title: "Profile adds more slices to user"
Description: """
Where SecondSliceProfile defined a [user] profile on .agent
This ThirdSliceProfile adds another [userorg] profile on .agent
Results in IG build error complaining about the slicing being different
"""
* agent ^slicing.discriminator.type = #pattern
* agent ^slicing.discriminator.path = "type"
* agent ^slicing.rules = #open
* agent contains 
    userorg 1..
* agent[userorg].type = http://terminology.hl7.org/CodeSystem/v3-RoleClass#PROV "healthcare provider"
* agent[userorg].who 1..1


Instance: ex-SecondSliceProfile
InstanceOf: SecondSliceProfile
Title: "Audit Example of second profile to show the build validation error"
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
* agent[user].extension[otherId][npi].valueReference.identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#NPI
* agent[user].extension[otherId][npi].valueReference.identifier.value = "1234567@myNPIregistry.example.org"
* agent[user].extension[otherId][provider-id].valueReference.identifier.type = http://terminology.hl7.org/CodeSystem/v2-0203#PRN
* agent[user].extension[otherId][provider-id].valueReference.identifier.value = "JohnD"


Instance: ex-ThirdSliceProfile
InstanceOf: ThirdSliceProfile
Title: "Audit Example of second profile to show the build validation error"
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

* agent[userorg].type = http://terminology.hl7.org/CodeSystem/v3-RoleClass#PROV "healthcare provider"
* agent[userorg].who.display = "St. Mary of Examples"
* agent[userorg].requestor = false






