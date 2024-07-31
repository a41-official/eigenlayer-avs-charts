# ARPA
ARPA threshold BLS network can serve as the infrastructure of verifiable random number generator (RNG), secure wallet, cross-chain bridge, decentralized custody etc.

## Recommend Hardware Requirements
- 1 vCPU
- 2G Memory
- 30G Storage

## Ports

### External Cluster Ports
- node_advertised_committer_rpc_endpoint: `50061`

### Internal Cluster Ports
- node_management_rpc_endpoint: `50091`
- node_statistics_http_endpoint: `50081`

## Secrets
- arpa node account keystore, keystore password
```
apiVersion: v1
kind: Secret
metadata:
  name: arpa-node-ecdsa-keystore
type: Opaque
data:
  json: YOUR_ARPA_KEY_BASE64_ENCODED
---
apiVersion: v1
kind: Secret
metadata:
  name: arpa-node-key-password
type: Opaque
data:
  json: YOUR_ARPA_KEY_PASSWORD_BASE64_ENCODED
```

## Commands

get kubeseal pem
```
kubeseal \
    --controller-name=sealed-secrets \
    --controller-namespace=kube-system \
    --fetch-cert > mycert.pem
```

create sealed secrets
```
kubeseal --format yaml --cert mycert.pem -n avs-a41-holesky -f ./secret.yaml > sealedSecret.yaml 
```

install
```
helm install arpa ./ -f ./values.yaml -n avs-a41-holesky
```


uninstall
```
helm uninstall arpa -n avs-a41-holesky
```
upgrade
```
helm upgrade arpa ./ -f ./values.yaml -n avs-a41-holesky
```
exec
```
k exec -it arpa-0 -n avs-a41-holesky -- /bin/sh
```

describe 
```
k describe po arpa-0  -n avs-a41-holesky
```

## ConfigMaps
- [`config.{network}.json`](https://github.com/ARPA-Network/BLS-TSS-Network/tree/main/docs)

## Refernece Links
- [Official Documentation](https://docs.arpanetwork.io/)
- [GitHub Configuration Repo](https://github.com/ARPA-Network/BLS-TSS-Network)