#!/bin/bash

###### install brew ######

echo "Instaling Homebrew"
NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#temporary setup of Homebrew
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

###### install packages ######

echo "Installing packages ..."
brew install zsh exa goto starship helix

###### install oh-my-zsh ######

echo "Installing Oh-my-zsh ..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" --unattended 

###### dotfiles install ######

echo "Installing dotfiles ..."
# Clone bare project
git clone --bare https://github.com/mrquentin/dotfiles.git $HOME/.dotfiles-cfg
# Add alias to manipulate project
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles-cfg --work-tree=$HOME'
# Backup conflicting files
mkdir -p .config-backup && dot checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
# Add alias to manipulate project
alias dot='/usr/bin/git --git-dir=$HOME/.dotfiles-cfg --work-tree=$HOME'
# Checkout dotfiles
dot checkout
# Configure project to not show untracked files
dot config --local status.showUntrackedFiles no

###### Start terminal ######
zsh