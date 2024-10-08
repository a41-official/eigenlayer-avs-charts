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
kubectl create secret generic --from-file key witnesschain-watchtower-ecdsa-key -n {{namespace}}
```
- file name should be `key`, as it will be used as filed name. The file contains private key in plain text.
- secret object name should be `witnesschain-watchtower-ecdsa-key`, only if you don't intent to modify this in value.



## ConfigMaps
- [`watchtower.config.json`](https://raw.githubusercontent.com/witnesschain-com/config/main/watchtower/watchtower.config.json)


## Refernece Links
- [Official Documentation](https://docs.witnesschain.com)
- [GitHub Configuration Repo](https://github.com/witnesschain-com/config)

