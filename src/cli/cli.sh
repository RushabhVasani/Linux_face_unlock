#!/bin/bash
FILE=/usr/share/pam-configs/Facerec
function facerec(){
if [ "$1" = "new" ]; then
    sudo python3 /lib/Auth/Facerec/add_new.py

elif [ "$1" = "enable" ]; then
    sudo cp /lib/Auth/Facerec/Facerec /usr/share/pam-configs/
    sudo pam-auth-update --package

elif [ "$1" = "disable" ]; then
    if test -f "$FILE"; then
        sudo rm /usr/share/pam-configs/Facerec
    fi
    sudo python3 /lib/Auth/Facerec/keyring_enable.py
    sudo pam-auth-update --package

elif [ "$1" = "remove" ]; then
    if test -f "$FILE"; then
        sudo rm /usr/share/pam-configs/Facerec
    fi
    sudo python3 /lib/Auth/Facerec/remove_cli.py
    sudo python3 /lib/Auth/Facerec/keyring_enable.py
    sudo chattr -R -i /lib/Auth/
    sudo rm -r /lib/Auth
    sudo rm /usr/share/bash-completion/completions/facerec
    sudo pam-auth-update --package

elif [ "$1" = "keyring_disable" ]; then
    sudo python3 /lib/Auth/Facerec/keyring_disable.py

elif [ "$1" = "keyring_enable" ]; then
    sudo python3 /lib/Auth/Facerec/keyring_enable.py

elif [ "$1" = "--help" ]; then
    python3 /lib/Auth/Facerec/cli_info.py

fi
}
