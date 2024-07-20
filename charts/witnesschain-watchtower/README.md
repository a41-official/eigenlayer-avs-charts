# Witnesschain Watchtower
Diligence watchtowers are the first line of defense for optimistic rollups. They enable incentive compatible and crypto-economically-secure Proof-of-Diligence (PoD) to make sure watchtowers are working in the happy path for optimistic rollups.

## Recommend Hardware Requirements
- 4+ cores CPU
- 16GB+ RAM
- SSD 1TB+ of free space
- 200+ Mbps Network Bandwidth Performance

## Ports

### External Cluster Ports
- N/A

### Internal Cluster Ports
- metrics: `9090`

## Secrets
- watchtower private key
```
apiVersion: v1
kind: Secret
metadata:
  name: holesky-watchtower-key
type: Opaque
data:
  watchtowerKey: YOUR_WATCHTOWER_KEY_BASE64_ENCODED
```

## ConfigMaps
- [`watchtower.config.json`](https://raw.githubusercontent.com/witnesschain-com/config/main/watchtower/watchtower.config.json)

## Refernece Links
- [Official Documentation](https://docs.witnesschain.com)
- [GitHub Configuration Repo](https://github.com/witnesschain-com/config)