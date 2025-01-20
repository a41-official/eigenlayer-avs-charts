# Ungate

InfiniRoute is an advanced AI Inference Composite that is developed by Ungate. It coordinates inference through a set of specialised models through an advanced routing engine to provide high intelligence performance.

## Secrets

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: ungate-attester-private-key
type: Opaque
data:
  privateKey: ""
```

## Commands

### Get Kubeseal Pem Key

```shell
kubeseal --controller-name=sealed-secrets --controller-namespace=kube-system --fetch-cert > mycert.pem
```

### Create Sealed Secrets

```shell
kubeseal --format yaml --cert mycert.pem -f secret.yaml > sealedSecret.yaml
```

## Reference Links

- [GitHub Deployment Repo](https://github.com/Ungate-Ai/infini-route-attestators-public-mainnet)
