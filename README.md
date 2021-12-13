# test-SlicingSlicedExtension

This creates a profile of [AuditEvent that slices .agent, adds otherId extension, and slices otherId](StructureDefinition-SecondProfile.html) 

Also added nesting that gives odd error
* Duplicate Element id AuditEvent.agent:user.extension:otherId

Example causes validation to fail. [Zulip chat](https://chat.fhir.org/#narrow/stream/215610-shorthand/topic/slicing.20an.20extension.20on.20a.20slice)

