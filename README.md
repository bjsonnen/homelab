# Homelab

Here you can find all config files for my homelab. 

## Principles

- Everything is deployed through FluxCD (GitOps)
- Using a public repo forces me to think more about security.

## Software

I'm currently using the following technologies:

- [Helm](https://helm.sh/) for templates.
- [Ubuntu](https://ubuntu.com/) Server 24.
- [FluxCD](https://fluxcd.io/) for GitOps.
- [Kubernetes](https://kubernetes.io/) with [k3s](https://k3s.io/).

## Hareware

There are currently no worker nodes. The operating system is [proxmox](https://www.proxmox.com).

The reason for proxmox is because I can play around. I can use Ubuntu server or switch to talos for a while.

I'm using a mini pc because:
- It costs almost as much as a refurbished device.
- I can add a second SSD with up to 2TB.
- I can upgrade the RAM to 64GB.
- I can upgrade the SSD to 2TB.
- It has a good CPU.

### Staging

Control Plane Node:
- NiPoGi AM16 Mini PC
  - AMD Ryzen 5 PRO 5675U (6C/12T)
  - 512GB NVME SSD
  - 16GB RAM

## Credits

Got the idea to make this repo public from [Mischa Van Den Burg](https://github.com/mischavandenburg/homelab).
