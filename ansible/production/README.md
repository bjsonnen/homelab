# How to

1. Create at least 2 VM with the standard Talos Linux ISO, one disk with 32GB and one disk with enough space for longhorn (like 100GB).
2. Add planned control plane node IPs to `inventory.yaml` under `[cpn]`. cpn stands for Control Plane Nodes.
3. Add planned worker node IPs to `inventory.yaml` under `[wn]`. wn stands for Worker Nodes.
4. Run `ansible-playbook production.yaml -i inventory.yaml`
5. Ansible will ask you for your GitHub API key and the correct SOPS key.