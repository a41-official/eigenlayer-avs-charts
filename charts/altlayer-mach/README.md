# Altlayer
AltLayer Mach AVS is a fast finality layer for Ethereum rollups. In Mach AVS , operators will run verifier nodes for rollups, monitor the rollup for fraudulent behavior, and submit a fraudulent alert to Mach AVS. Fraudulent alert can then be confirmed via sufficient quorum or ZK proofs.

## Hardware requirements
- 4 CPU
- 16GB Memory
- 500GB SSD
- Ubuntu 22.04 LTS
- Docker v24 and above
- EigenLayer CLI
- Full node with RPC service or managed RPC services for the target rollup

## Ports
### External Cluster Ports
- N/A

### Internal Cluster Ports
- node api: `9010`
- eigen metrics: `9092`
- verifier metrics: `9094`

## Secrets
- bls_key.json
- blsKeyPassword
```
apiVersion: v1
kind: Secret
metadata:
  name: "MACH-BLS-KEY-JSON"
  labels: {}
stringData:
  bls_key.json: |
    {}
---

apiVersion: v1
kind: Secret
metadata:
  name: "MACH-BLS-KEY-PASSWORD-JSON"
  labels: {}
stringData:
  blsKeyPassword: ""
```

## ConfigMap
- [genesis.json](https://github.com/alt-research/mach-avs-operator-setup/tree/master)
- [mach-config.toml](https://github.com/alt-research/mach-avs-operator-setup/tree/master)

## Reference link
- [docs](https://docs.altlayer.io/altlayer-documentation/altlayer-facilitated-actively-validated-services/altlayer-mach-avs-for-op-mainnet/operator-guide)
- [chart](https://github.com/alt-research/mach-avs-operator-setup/tree/master/helm-charts/mach-operator)
