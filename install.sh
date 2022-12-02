#!/bin/bash

###### install brew ######

echo "Instaling Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

###### install packages ######

echo "Installing packages ..."
brew install zsh exa goto starship helix

###### install oh-my-zsh ######

echo "Installing Oh-my-zsh ..."
/bin/bash -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

###### dotfiles install ######

echo "Installing dotfiles ..."
# Clone bare project
git clone --bare https://github.com/mrquentin/dotfiles.git $HOME/.dotfiles-cfg
# Add alias to manipulate project
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles-cfg --work-tree=$HOME'
# Backup conflicting files
mkdir -p .config-backup && dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
# Checkout dotfiles
dot checkout
# Configure project to not show untracked files
dot config --local status.showUntrackedFiles no

###### Start terminal ######
zsh