# ADR-001: HiveMQ Image Strategy

## Status


## Context
HiveMQ is required for the OEE platform.

Open decision (CP-H-07):
Determine whether a HiveMQ extension JAR is required.

## Decision
Two approaches are prepared:

1. Wrapper Dockerfile  
   Used only if an extension JAR must be baked into the image.

2. Vendor Image Direct  
   Used if only configuration is required.


## Consequences

- If extension JAR is required → custom Docker image will be maintained.  
- If not required → vendor image will be used directly with ConfigMap.  

## References

- ADR-011 (Image Tagging)  
- ADR-017 (Security Hardening)