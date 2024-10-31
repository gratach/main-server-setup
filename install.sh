#!/bin/bash

# Exit on error
set -e

# Check if the user "webuser" exists
if id -u scriptuser &>/dev/null; then
    echo "User \"scriptuser\" already exists"
else
    echo "Creating user \"scriptuser\""
    useradd -m -s /bin/bash scriptuser
fi

# Move the static-user directory to the home directory of the user "scriptuser"
if [ -d /home/scriptuser/static-user ]; then
    echo "File \"static-user\" already exists in /home/scriptuser"
else
    echo "Copying \"static-user\" to /home/scriptuser"
    mv $(dirname $0)/static-user /home/scriptuser/static-user
fi

echo "Changing ownership of the static-user directory to user \"scriptuser\""
chown -R scriptuser:scriptuser /home/scriptuser/static-user

# Iterate over all lines in the file static-root/install-order.txt
cat $(dirname $0)/static-root/install-order.txt | while read line || [[ -n $line ]]; do
    echo "Installing module \"$line\""
done