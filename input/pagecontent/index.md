# test Slicing Sliced Extensions

This creates a profile of [AuditEvent that slices .agent, adds extOtherId extension, and slices extOtherId](StructureDefinition-ThirdSliceProfile.html) 

1. I need to slice the AuditEvent.agent as there are multiple kinds of agent the profile is defining, so want to identify a slice for the (user) agent.
2. In that slice for describing the user, I have more identifiers to record than the AuditEvent.agent supports. so I add an extension [OtherIds](StructureDefinition-OtherId.html)
3. In that extension that allows me to record more identifiers, I have a some flavors of identifier that I also want to define (npi, and prn) **These don't seem to be converted from FSH to SD properly, or the IG builder doesn't handle the situation**
4. In that extension I have another extension [otherIdName](StructureDefinition-OtherIdName.html) to add a name to the given identifier in the given slice in the given agent **Note this works fine here**


Example causes [validation of examples to fail](qa.html). 

- [sushi Zulip chat](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/slicing.20an.20extension.20on.20a.20slice)
- [IG Creation zulip chat](https://chat.fhir.org/#narrow/stream/179252-IG-creation/topic/slicing.20sliced.20extension)

[github repo](https://github.com/JohnMoehrke/SlicingSlicedExtension)
