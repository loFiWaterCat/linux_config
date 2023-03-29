#!/bin/bash

# Run this script as sudo

# Root directory here
linux_config=$(git rev-parse --show-toplevel)

# Setup packages
xbps-install -Su $(cat ${linux_config}void_linux_pkglist.txt)
# Setup permissions
printf "permit :wheel\n" > /etc/doas.conf

# Setup directories
source setup_dirs.sh

# Make symlinks
rm -i ${HOME}/.bash_profile
ln -s ${linux_config}/bash_files/.bash_profile ${HOME}
source ${HOME}/.bash_profile
rm -i ${HOME}/.bashrc
ln -s ${linux_config}/bash_files/.bashrc ${HOME}
source ${HOME}/.bashrc
rm -rfi ${HOME}/.config
ln -s ${linux_config}/.config ${HOME}  
rm -i ${HOME}/.gitconfig
ln -s ${linux_config}/.config/git/.gitconfig ${HOME}

# Setup programs
# river
source install_river.sh
source install_helix.sh

# Setup languages
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Setup services
# Setup session management
usermod -aG _seatd ${USER}