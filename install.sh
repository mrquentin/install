#!/bin/bash

###### install brew ######

echo "Instaling Homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
#temporary setup of Homebrew
echo '# Set PATH, MANPATH, etc., for Homebrew.' >> $HOME/.profile
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> $HOME/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

###### install packages ######

echo "Installing packages ..."
brew install zsh exa goto starship helix direnv

###### install oh-my-zsh ######

echo "Installing Oh-my-zsh ..."
curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh --output install.sh
sh install.sh --unattended --keep-zshrc
rm install.sh

###### dotfiles install ######

git clone --bare https://github.com/mrquentin/dotfiles.git $HOME/.dotfiles-cfg

config () {
   /usr/bin/git --git-dir=$HOME/.dotfiles-cfg/ --work-tree=$HOME $@
}

mkdir -p .config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .config-backup/{}
fi;
config checkout
config config status.showUntrackedFiles no
