# homelab infra

This repo was inspired by the k8s-at-home [flux-cluster-template](github.com/k8s-at-home/flux-cluster-template), but was built from scratch.

## Bootstrap Procedure

```sh
# Create the flux-system namespace, so the sops-age secret has
# somewhere to go
kubectl create namespace flux-system

# Upload the sops-age secret, used for decrypting secrets
cat ~/.config/sops/age/keys.txt |
  kubectl create secret generic sops-age \
  --namespace=flux-system \
  --from-file=age.agekey=/dev/stdin

# Run the flux bootstrap command
flux bootstrap git --url=ssh://git@github.com/belak/homelab-infra.git --branch=main --path=cluster/bootstrap --private-key-file=$HOME/.ssh/id_flux --silent
```

## Repo Structure

- `bootstrap` - contains a set of ansible playbooks and other tools for deploying k3s to a set of hosts
- `cluster/bootstrap`
- `cluster/secrets`
- `cluster/<namespace>`

### Namespaces

- `cert-manager`
- `flux-system`
- `longhorn-system`
- `metalkb-system`
- `traefik-system`

- `dev` - applications for development use, such as Gitea
- `home` - applications for home use, such as Nextcloud
- `media` - applications for media use, such as Plex
- `personal-dan` - applications running for Dan, such as the BTTA Leaderboard
- `seabird` - seabird deployment

### Applications

## Network

- 192.168.42.1/24 - Physical hosts
- 192.168.43.1/24 - Services
- 10.42.0.0/16 - Internal K8S Pods
- 10.43.0.0/16 - Internal K8S Services

## Exported Services

Most services will only end up being cluster-internal, but we still need to expose a few services for external use.

- 192.168.43.1 - Traefik - Exposed for port forwarding
- 192.168.43.2 - Postgres - Exposed so Ansible can create databases and credentials
