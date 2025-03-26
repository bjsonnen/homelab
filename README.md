# Homelab

In my free time I'm running an enterprise Kubernetes cluster on my home server. I'm using it for learning and playing around. Using GitOps with a public repo forces me to think about security, backups, scalability and maintenance. 

All apps are deployed via GitOps and [FluxCD](https://fluxcd.io/). I picked FluxCD over [ArgoCD](https://argoproj.github.io/) because it forces me to use the CLI and not a web interface. Some apps are usable outside my local network. This is done with [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/).

## Principles

- Everything is deployed through FluxCD (GitOps)
- Using a public repo forces me to think more about security.
- All apps are supposed to work in production. First I need a second mini pc for that. 
- Secrets are stored inside this git repository. All are encrypted. I'm using [CNCF SOPS](https://fluxcd.io/flux/guides/mozilla-sops/) for encryption.
- Storage is managed through [Longhorn](https://longhorn.io/).

## How to

### General info

- Make sure you install `nfs-common`. It's used by Longhorn.

### Setup

Run `./setup.sh`

Or:

- Create a Kubernetes cluster. For example run `talosctl cluster create --workers=3` to create a development Talos Linux cluster with 3 worker nodes and 1 control plane node.
- Check if FluxCD supports your Kubernetes cluster:
```
flux check --pre
```
- Export these values and make sure you add your own token/username:
```
export GITHUB_TOKEN=<your-token>
export GITHUB_USER=<your-username>
```
- Create the flux system:
```
flux bootstrap github \
  --owner=$GITHUB_USER \
  --repository=homelab \
  --branch=main \
  --path=./clusters/staging \
  --personal
```
- Create a SOPS age key file: `age-keygen -o age.agekey`
- Use the private key as secret for flux:
```
cat age.agekey |
kubectl create secret generic sops-age \
--namespace=flux-system \
--from-file=age.agekey=/dev/stdin
```

## Software

I'm currently using the following technologies:

### Applications

<table>
    <tr>
        <th>
            Logo
        </th>
        <th>
            Name
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/homepage.svg">
        </td>
        <td>
            <a href="https://github.com/gethomepage/homepage">Homepage</a>
        </td>
        <td>
            A modern and open-source dashboard application configurable via a YAML file.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" src="https://github.com/bjsonnen/homelab/blob/main/images/nextcloud.png">
        </td>
        <td>
            <a href="https://nextcloud.com">Nextcloud</a>
        </td>
        <td>
            An open-source self-hosted file storage. Made available to the public via a Cloudflare Tunnel.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/linkding.svg">
        </td>
        <td>
            <a href="https://github.com/sissbruecker/linkding">linkding</a>
        </td>
        <td>
            linkding is a self-hosted open-source bookmark manager.
        </td>
    </tr>
</table>

### Storage

<table>
    <tr>
        <th>
            Logo
        </th>
        <th>
            Name
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/longhorn.svg">
        </td>
        <td>
            <a href="https://longhorn.io/">Longhorn</a>
        </td>
        <td>
            Cloud-native production-ready management for <a href="https://en.wikipedia.org/wiki/Block_(data_storage)">Block Storage</a> for Kubernetes.
        </td>
    </tr>
</table>

### System

#### General

Both production and staging use these tools too, but also specific tools to their needs. 
Because I want to be able to check what's going on in staging, I'm using Ubuntu with k3s. 
In production, I only want to deploy what's working. Therefore I'm using Talos.

<table>
    <tr>
        <th>
            Logo
        </th>
        <th>
            Name
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/proxmox.png">
        </td>
        <td>
            <a href="https://www.proxmox.com/en/">Proxmox</a>
        </td>
        <td>
            Enterprise software for virtualization. Used to play around and switch from Ubuntu to for example <a href="https://www.talos.dev/">Talos Linux</a>.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/fluxcd.png" >
        </td>
        <td>
            <a href="https://fluxcd.io/">FluxCD</a>
        </td>
        <td>
            A CNCF project for continuous and progressive delivery of Kubernetes applications and infrastructure. It's used to enable GitOps.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/helm.svg" >
        </td>
        <td>
            <a href="helm.sh">Helm</a>
        </td>
        <td>
            A package manager for Kubernetes. With Helm you can install applications directly to Kubernetes. Used to provide templates which are then reconfigured.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/traefik.svg" >
        </td>
        <td>
            <a href="https://github.com/traefik/traefik">traefik</a>
        </td>
        <td>
            An ingress reverse proxy used internally by Kubernetes. 
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/cloudflare.png">
        </td>
        <td>
            <a href="https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/">Cloudflare Tunnel</a>
        </td>
        <td>
            Creates a secure connection to Kubernetes pods without a publicly routable IP address.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/cncf.svg">
        </td>
        <td>
            <a href="https://www.cncf.io/projects/sops/">CNCF SOPS</a>
        </td>
        <td>
            Encrypts and decrypts files like YAML, JSON, ENV, INI, etc. Used for public secrets.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/ansible.svg">
        </td>
        <td>
            <a href="https://www.ansible.com/">Ansible</a>
        </td>
        <td>
            Used to automate the setup of virtual machines.
        </td>
    </tr>
</table>

#### Production

<table>
    <tr>
        <th>
            Logo
        </th>
        <th>
            Name
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/talos.svg" >
        </td>
        <td>
            <a href="https://talos.dev/">Talos</a>
        </td>
        <td>
            An open-source operating systems focused on Kubernetes (Used only in production).
        </td>
    </tr>
</table>

#### Staging

<table>
    <tr>
        <th>
            Logo
        </th>
        <th>
            Name
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/ubuntu.png" >
        </td>
        <td>
            <a href="https://ubuntu.com/">Ubuntu</a>
        </td>
        <td>
            An open-source operating system developed by Canonical (Used only in staging).
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/k3s.png" >
        </td>
        <td>
            <a href="https://k3s.io/">k3s</a>
        </td>
        <td>
            A secure and lightweight Kubernetes distribution designed for production environments (Only used in staging).
        </td>
    </tr>
</table>

### Continuous Integration Tests

<table>
    <tr>
        <th>
            Logo
        </th>
        <th>
            Name
        </th>
        <th>
            Description
        </th>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/kubelinter.svg">
        </td>
        <td>
            <a href="https://github.com/stackrox/kube-linter">KubeLinter</a>
        </td>
        <td>
            Open-Source tool for highlighting typos and security problems for Kubernetes YAML manifests.
        </td>
    </tr>
</table>

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
- Ubuntu 24 VM
  - 4 CPU Cores
  - 100GB SSD
  - 4GB RAM

Scheduling is activated on the control plane node. Only used for testing.

### Production

Control Plane Node:
- NiPoGi AM16 Mini PC
  - AMD Ryzen 5 PRO 5675U (6C/12T)
  - 2TB NVME SSD
  - 64GB RAM

Through [Proxmox](https://www.proxmox.com/en/) I created 5 VMs with [Talos Linux](https://www.talos.dev/).
- Control Plane Node (1)
  - 2 CPU Cores
  - 32GB SSD
  - 2GB RAM
- Worker Nodes (4)
  - 2 CPU Cores
  - 32GB SSD
  - 2 GB RAM

Scheduling is deactivated on the control plane node.
The CNCF SOPS age keys are different than the staging keys.
