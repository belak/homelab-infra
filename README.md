# homelab infra

This repo was inspired by the k8s-at-home [flux-cluster-template](github.com/k8s-at-home/flux-cluster-template), but was built from scratch with a number of different design decisions.

## Repo Structure

- `bootstrap` - contains a set of ansible playbooks and other tools for deploying k3s to a set of hosts
- `cluster` - contains a collection of namespaces
- `cluster/core` - this deploys k8s-specific resources needed cluster-wide
- `cluster/<namespace>` - each namespace folder contains separate folders for each application
- `cluster/<namespace>/<application>` - each application folder contains the configuration needed to deploy that application

### Namespaces

- `argocd`
- `cert-manager`
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

## Exported Services

Most services will only end up being cluster-internal, but we still need to expose a few services for external use.

- 192.168.43.1 - Traefik - Exposed for port forwarding
