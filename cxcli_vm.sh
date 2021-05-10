#!/usr/bin/env bash
OP="$1"
VM_NAME="$2"

if [ "$VM_NAME" = "" ]; then
	VM_NAME="cxcli"
fi

if [ !-d ./shared ]; then
	mkdir ./shared
	touch ./shared/mounted.txt
	echo "This is mounted from the host computer!" > ./shared/mounted.txt
fi

if [ "$OP" = "setup" ]; then
	multipass launch -n $VM_NAME --cloud-init ./cloud-init.yaml
	multipass mount ./shared $VM_NAME
	multipass shell $VM_NAME
elif [ "$OP" = "delete" ]; then
	multipass stop $VM_NAME && multipass delete $VM_NAME && multipass purge
else 
	echo "Error!"
	echo "No or unknown switch supplied."
	echo
	echo "cxcli_vm.sh <setup | delete> [name_of_vm]"
	echo
	echo "If not supplied the VM name will default to 'cxcli'"
fi
