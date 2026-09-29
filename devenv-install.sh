#!/bin/bash

set -uo pipefail

/usr/bin/git clone --bare $HOME/.cfg-installer $HOME/.cfg

function config {
   /usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME $@
}
mkdir -p $HOME/.config-backup
config checkout
if [ $? = 0 ]; then
  echo "Checked out config."
  else
    echo "Backing up pre-existing dot files.";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv $HOME/{} $HOME/.config-backup/{}
fi

set -e

config checkout
config config status.showUntrackedFiles no

sudo apt update
sudo apt install -y neovim fzf ripgrep starship tree-sitter-cli

# coursier doesn't have a usable ubuntu package atm :(
curl -fLso- 'https://github.com/VirtusLab/coursier-m1/releases/download/v2.1.24/cs-aarch64-pc-linux.gz' | gzip -d | sudo tee /usr/local/bin/cs >/dev/null
sudo chmod +x /usr/local/bin/cs

sudo chsh -s /usr/bin/zsh

nvim --headless "+Lazy! sync" +qa

