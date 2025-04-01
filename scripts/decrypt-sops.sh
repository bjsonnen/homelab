#!/bin/bash

if [ -z "${sops_private_key}" ]; then
	echo -n "SOPS private key: "
	read -rs sops_private_key
	export SOPS_AGE_KEY=$sops_private_key
fi

DECRYPTED_CONTENT=$(sops --decrypt "$1" 2>&1)
STATUS=$?

if [ $STATUS -eq 0 ]; then
	echo "$DECRYPTED_CONTENT" > ./output-decrypted.yaml
fi
