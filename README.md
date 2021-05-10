# Multipass-cxcli
 A cloud-init file and simple bash script to set up the Citrix Cloud cx cli tool in a Multipass VM.

## Setup

1. Clone this repo (i.e. `git clone https://github.com/StuartP-CSP/Multipass-cxcli.git`)
2. Change in cloned repo (i.e. `cd Multipass-cxcli`)
3. Make the setup script (`cxcli_vm.sh`) executable (i.e. `chmod +x ./cxcli_vm.sh`)
4. Run the setup script, with the cli argument `setup` (i.e. `./cxcli_vm.sh setup`)
5. Optionally you can specify your own name for the VM (i.e. `./cscli_vm.sh setup myvm`)
6. The `cxcli` (or vm using the name you spcified) will be set as the new 'primary' (aka default) VM for multipass.

## Usage
Once the base VM image is downloaded, the VM will launch and configure using the `cloud-init.yaml` file. this performs the following functions:
- install prerequisites, including `gnome-keyring`
- install Python3 requirments
- `pip install`s the `cxcli` module
- modifies the `/etc/pam.d/login` to start the `gnome-keyring`
- modifies the default users (`ubuntu`) `.profile` to prompt to unlock login keyring 
- sets the password for the default user to `Citrix123`. This could and should be changed using `passwd`! :)

It also installs also installs `wget` and `jq` as you need something to deal with the returned JSON.

## Optional components
You can uncomment the options sections in the cloud init file to install either ABS-Lang and/or PowerShell Core. Either or both of these help with working with the returned JSON.

## Usage
After the set up is completed you will be taken to the VM shell and prompted for the password to unlock the keyring (default = Citrix123).

Once set you should configure `cx` with `cx --configure`.

Once finished with the VM, close the window or quit (using `exit`) and either suspend or stop the VM with Multipass (i.e. `multipass stop` or `multipass suspend`)

## Deletion
You can remove the VM by using the setup script, with the `delete` arguement (i.e. `./cxcli_vm.sh delete`). If you opted to specify a different name for the VM, that needs to be specified (i.e. `/cxcli_vm.sh delete myvm`)
