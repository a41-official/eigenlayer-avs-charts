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

- arpa node account keystore, keystore password, aws s3 credential
```
apiVersion: v1
kind: Secret
metadata:
  name: arpa-node-ecdsa-keystore
type: Opaque
data:
  keystore: 
---
apiVersion: v1
kind: Secret
metadata:
  name: arpa-node-ecdsa-password
type: Opaque
data:
  password:
---
apiVersion: v1
kind: Secret
metadata:
  name: aws-secret
type: Opaque
data:
  awsAccessKeyId: 
  awsSecretAccessKey: 
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
helm install arpa ./ -f ./values.yaml -n avs-a41-mainnet
```

uninstall
```
helm uninstall arpa -n avs-a41-mainnet
```

upgrade
```
helm upgrade arpa ./ -f ./values.yaml -n avs-a41-holesky
```

logs
```
k logs -f arpa-0 -n avs-a41-holesky
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