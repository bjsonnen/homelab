# Homelab

In my free time I'm running an enterprise Kubernetes cluster on my home server. I'm using it for learning and playing around. Using GitOps with a public repo forces me to think about security, backups, scalability and maintenance. 

All apps are deployed via GitOps and [FluxCD](https://fluxcd.io/). I picked FluxCD over [ArgoCD](https://argoproj.github.io/) because it forces me to use the CLI and not a web interface. Some apps are usable outside my local network. This is done with [Cloudflare Tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/).

## Principles

- Storage is managed through [Longhorn](https://longhorn.io/).
- Everything is deployed through FluxCD (GitOps)
- Using a public repo forces me to think more about security.
- All apps are supposed to work in production. First I need a second mini pc for that. 
- Secrets are stored inside this git repository. All are encrypted. I'm using [CNCF SOPS](https://fluxcd.io/flux/guides/mozilla-sops/) for encryption.

## How to

### General info

- Make sure you install `nfs-common`. It's used by Longhorn.

### Setup

#### Requirements:

- Have an Ubuntu 24 VM or server

#### How to:

- Move into the `ansible/` folder.
- Add your VM/server's IP to the `inventory.yaml` with a new line under `[staging]`.
- Run `ansible-playbook staging.yaml -i inventory`.

This will configure your VM, install k3s and install the flux operator.
But be warned. This repo makes use of encrypted secrets via CNCF SOPS. Flux will complain that you never added the correct private key. But longhorn and the prometheus stack should start. 

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
            A modern and open-source dashboard application configurable via a YAML file. It's using <a href="https://longhorn.io/">Longhorn</a> for storing the config files.
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
            linkding is a self-hosted open-source bookmark manager. Storage is provided by <a href="https://longhorn.io/">Longhorn</a>.
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
            An open-source self-hosted file storage. Made available to the public via a Cloudflare Tunnel. To store files, it uses a volume by <a href="https://longhorn.io/">Longhorn</a> and uses <a href="https://cloudnative-pg.io/">CloudNativePG</a> for it's database.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/n8n.svg">
        </td>
        <td>
            <a href="https://n8n.io/">n8n</a>
        </td>
        <td>
            n8n is a workflow automation platform that combines AI capabilities with business process automation. n8n is using <a href="https://longhorn.io/">Longhorn</a> for storage. On top, it uses <a href="https://cloudnative-pg.io/">CloudNativePG</a> for it's database.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/open-webui.svg">
        </td>
        <td>
            <a href="https://github.com/open-webui/open-webui">Open-WebUI</a>
        </td>
        <td>
            Open-WebUI makes use of Ollama to offer a web-interface for accessing local LLMs. It's using <a href="https://longhorn.io/">Longhorn</a> for storage. Flux uses <a href="https://helm.sh/">Helm</a> to install it.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/ollama.svg">
        </td>
        <td>
            <a href="https://github.com/ollama/ollama">Ollama</a>
        </td>
        <td>
            Ollama is a tool for running and managing local open-source AI models. It's using the <a href="https://ollama.com/library/tinyllama">Tinyllama</a> model and <a href="https://longhorn.io/">Longhorn</a> for storage.
        </td>
    </tr>
</table>

### Database

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
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/cnpg.svg">
        </td>
        <td>
            <a href="https://cloudnative-pg.io/">CloudNativePG</a>
        </td>
        <td>
            A cloud-native Kubernetes operator for the PostgreSQL database. CloudNativePG uses <a href="https://longhorn.io/">Longhorn</a> for storing data.
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
            Cloud-native production-ready management for <a href="https://en.wikipedia.org/wiki/Block_(data_storage)">Block Storage</a> for Kubernetes. Used as the default storage option for new persistent volume claims.
        </td>
    </tr>
</table>

### System

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
            Talos Linux is a minimal, hardened, immutable, and open-source Linux distribution designed for Kubernetes.
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
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/k3s.png" >
        </td>
        <td>
            <a href="https://k3s.io/">k3s</a>
        </td>
        <td>
            K3s is a highly available Kubernetes distribution designed for production workloads in unattended, resource-constrained, remote locations or inside IoT appliances.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" height="32" src="https://github.com/bjsonnen/homelab/blob/main/images/ubuntu.png" >
        </td>
        <td>
            <a href="https://ubuntu.com/">Ubuntu</a>
        </td>
        <td>
            Ubuntu is the modern, open-source operating-system on Linux for the enterprise server, desktop, cloud, and IoT by Canonical.
        </td>
    </tr>
</table>

#### General

Both production and staging use these tools, but also specific tools to their needs. 
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

### Staging

Control Plane Node:
- Ubuntu 24 VM
  - 10 CPU Cores
  - 200GB SSD
  - 50GB RAM

Scheduling is activated on the control plane node. Only used for testing.

### Production

Control Plane Nodes:
- 3x Talos Linux VM:
  - 4 CPU Cores
  - 50GB SSD
  - 4GB RAM

Worker Nodes:
- 4x Talos Linux VM:
  - 3 CPU Cores
  - 50GB SSD
  - 3GB RAM

Scheduling is deactivated on the control plane nodes.
