#!/bin/sh

set -e
cd "$(dirname "$0")"

# MAKE SURE THIS IS EXECUTED AGAINST A REMOTE VM
if [ "$1" != "run" ]; then
	echo "To setup dnf-automatic locally, execute:"
	printf "\t$0 run\n"
	echo
	echo "To setup dnf-automatic on a remote system, execute the following:"
	printf "\tssh user@server 'bash -s run' < ./install.sh\n"
	exit 1
fi

#####################

# INSTALL
sudo dnf -y install dnf-automatic dnf-utils

# CONFIGURE
cp /etc/dnf/automatic.conf /tmp/automatic.conf.original
sudo sed -i -E 's/^\s*#?\s*(apply_updates)\s*=.*/\1 = yes/' /etc/dnf/automatic.conf
sudo sed -i -E 's/^\s*#?\s*(upgrade_type)\s*=.*/\1 = security/' /etc/dnf/automatic.conf
if diff /tmp/automatic.conf.original /etc/dnf/automatic.conf >/dev/null 2>&1; then
	echo "No changes made to configuration file"
else
	echo "Changes were made to configuration file"
fi

# ENABLE STARTUP
sudo systemctl enable dnf-automatic.timer
if systemctl status dnf-automatic.timer >/dev/null; then
	echo "Already running"
	echo "Restarting . . ."
else
	echo "Not running"
	echo "Starting . . ."
fi

# RESTART TIMER
if sudo systemctl restart dnf-automatic.timer; then
	echo "Successfully started dnf-automatic"
else
	echo "There was an error starting dnf-automatic"
fi

# LIST TIMER
sudo systemctl list-timers dnf-automatic.timer



