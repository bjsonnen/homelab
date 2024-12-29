# Homelab

Here you can find all config files for my homelab. 

## Principles

- Everything is deployed through FluxCD (GitOps)
- Using a public repo forces me to think more about security.

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
            <img width="32" src="https://github.com/meowosaurus/homelab/blob/main/images/nextcloud.png">
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
            <img width="32" src="https://github.com/meowosaurus/homelab/blob/main/images/linkding.svg">
        </td>
        <td>
            <a href="https://github.com/sissbruecker/linkding">linkding</a>
        </td>
        <td>
            linkding is a self-hosted open-source bookmark manager.
        </td>
    </tr>
</table>

### System

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
            <img width="32" src="https://github.com/meowosaurus/homelab/blob/main/images/proxmox.png">
        </td>
        <td>
            <a href="https://www.proxmox.com/en/">Proxmox</a>
        </td>
        <td>
            Enterprise software for virtualization.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" src="https://github.com/meowosaurus/homelab/blob/main/images/ubuntu.png" >
        </td>
        <td>
            <a href="https://ubuntu.com/">Ubuntu</a>
        </td>
        <td>
            An open-source operating system developed by Canonical.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" src="https://github.com/meowosaurus/homelab/blob/main/images/fluxcd.png" >
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
            <img width="32" src="https://github.com/meowosaurus/homelab/blob/main/images/helm.svg" >
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
            <img width="32" src="https://github.com/meowosaurus/homelab/blob/main/images/k3s.png" >
        </td>
        <td>
            <a href="https://k3s.io/">k3s</a>
        </td>
        <td>
            A secure and lightweight Kubernetes distribution designed for production environments.
        </td>
    </tr>
    <tr>
        <td>
            <img width="32" src="https://github.com/meowosaurus/homelab/blob/main/images/cloudflare.png">
        </td>
        <td>
            <a href="https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/">Cloudflare Tunnel</a>
        </td>
        <td>
            Creates a secure connection to Kubernetes pods without a publicly routable IP address.
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
- NiPoGi AM16 Mini PC
  - AMD Ryzen 5 PRO 5675U (6C/12T)
  - 512GB NVME SSD
  - 16GB RAM

## Credits

Got the idea to make this repo public from [Mischa Van Den Burg](https://github.com/mischavandenburg/homelab).
