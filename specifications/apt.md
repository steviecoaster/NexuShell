# Repository Format: Apt

## Format: Hosted

### Spec

#### Section: General

| Name | Definition | Required | Type | Example |
| ---- | ----| ---- | ---- | ---- |
| name | A unique identifier for this repository| yes | String | internal |
| online| Whether this repository accepts incoming requests | yes | Boolean | true

#### Section : Storage

| Name | Definition | Required | Type | Example
| ---- | ---- | ---- | ---- | ---- |
| blobStoreName | Blob store used to store repository contents | yes | string | default |
| strictContentTypeValidation | Whether to validate uploaded content's MIME type appropriate for the repository format | yes | Boolean | true |
| writePolicy | Controls if deployments of and updates to assets are allowed | yes | string | "allow" |

#### Section : Cleanup

| Name | Definition | Required | Type | Example |
| ---- | ---- | ---- | ---- | ---- |
| policyNames | Components that match any of the applied policies will be deleted | no | String | null |

#### Section : Component

| Name | Definition | Required | Type | Example |
| ---- | ---- | ---- | ---- | ---- |
| proprietaryComponents | Components in this repository count as proprietary for namespace conflict attacks (requires Sonatype Nexus Firewall) | no | Boolean | false |

#### Section : Apt

| Name | Definition | Required | Type | Example |
| ---- | ---- | ---- | ---- | ---- |
| distribution | Distribution to fetch | yes | String | bionic |

#### Section : AptSigning

| Name | Definition | Required | Type | Example |
| ---- | ---- | ---- | ---- | ---- |
| keypair | PGP signing key pair (armored private key e.g. gpg --export-secret-key --armor) | yes | string | 1h2332 |
| passphrase | Passphrase to access PGP signing key | no | string | null |

### Example

```json
{
  "name": "internal",
  "online": true,
  "storage": {
    "blobStoreName": "default",
    "strictContentTypeValidation": true,
    "writePolicy": "allow_once"
  },
  "cleanup": {
    "policyNames": [
      "string"
    ]
  },
  "component": {
    "proprietaryComponents": true
  },
  "apt": {
    "distribution": "bionic"
  },
  "aptSigning": {
    "keypair": "string",
    "passphrase": "string"
  }
}
```

## Format: Proxy

### Spec

### Example

## Format: Group

### Spec

### Example

## NOTES
