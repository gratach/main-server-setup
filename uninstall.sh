#!/bin/bash

# Exit on error
set -e

# Only continue if the script is not executed from the file /home/scriptuser/install.sh
if [ "$(realpath $0)" == "/home/scriptuser/install.sh" ]; then
    echo "This script cannot be executed from /home/scriptuser/install.sh"
    exit 1
fi

# Move the directory /home/scriptuser/static-user to the script directory
if [ -d /home/scriptuser/static-user ]; then
    echo "Copying /home/scriptuser/static-user to the script directory"
    mv /home/scriptuser/static-user $(dirname $0)/static-user
else
    echo "File /home/scriptuser/static-user does not exist"
fi

echo "Changing ownership of the static-user directory to the current user"
chown -R $(whoami):$(whoami) $(dirname $0)/static-user

# Remove user "scriptuser"
if id -u scriptuser &>/dev/null; then
    echo "Removing user \"scriptuser\""
    userdel -r scriptuser
else
    echo "User \"scriptuser\" does not exist"
fi