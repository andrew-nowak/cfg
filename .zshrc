echo 'Sourcing .zshrc...'
############################
#                          #
#          zshrc           #
#                          #
############################

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=8000
SAVEHIST=16000
setopt HIST_IGNORE_SPACE
# bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename "$HOME/.zshrc"
bindkey '^R' history-incremental-search-backward
setopt interactivecomments

# End of lines added by compinstall

export PATH="/usr/local/bin:$PATH"

# prompt
eval "$(starship init zsh)"

#setup keys
source $HOME/.zsh_keys

# aliases
source $HOME/.zsh_aliases

export EDITOR='vim'
export VISUAL='vim'

###################
# Dev environment #

# Fixes for homebrew doing homebrew things
#[ -d "/usr/local/opt/openssl/bin" ] && export PATH="/usr/local/opt/openssl/bin:$PATH"

[ -d "/usr/local/opt/coreutils/libexec/gnubin" ] && export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
[ -d "/usr/local/opt/coreutils/libexec/gnuman" ] && export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

#[ -d "/usr/local/opt/curl/bin" ] && export PATH="/usr/local/opt/curl/bin:$PATH"

[ -d "/usr/local/opt/python/libexec/bin" ] && export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Programming language version management

# nvm
export NVM_DIR="$HOME/.nvm"
if [ -d "/usr/local/opt/nvm" ]; then
  # Homebrew nvm recommends using the /usr/local/opt/nvm init script
  . "/usr/local/opt/nvm/nvm.sh"
elif [ -d "$HOME/.nvm" ]; then
  # But if we're not using homebrew, we should use the real nvm script
  . "$HOME/.nvm/nvm.sh"
fi

# rbenv
if [ -d "$HOME/.rbenv" ]; then
  export PATH="$HOME/.rbenv/shims:$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# rustup
if [ -d "$HOME/.cargo" -a -e "$HOME/.cargo/env" ]; then
  . $HOME/.cargo/env
fi

if [ -d "$HOME/code/go/bin" ]; then
  export PATH="$HOME/code/go/bin:$PATH"
  export GOPATH="$HOME/code/go"
fi

# Put random / non-system managed binaries in ~/bin
# THIS IS POTENTIALLY DANGEROUS but also really useful 🤷
#export PATH="$HOME/bin:$PATH"

autoload -Uz compinit
compinit

if [[ "$(uname)" = "Darwin" ]]; then
  jdk() {
    if [[ -n "$1" ]]; then
      version=$1
      export JAVA_HOME=$(/usr/libexec/java_home -v"$version");
      java -version
    else
      /usr/libexec/java_home -V 2>&1 | grep x86_64 | awk '{$1=$1};1' | cut -d' ' -f1 -
    fi
  }
  DEFAULT_JDK=1.8
  export JAVA_HOME="$(/usr/libexec/java_home -v$DEFAULT_JDK)"
fi

if 2>&1 >/dev/null which rg ; then
  export FZF_DEFAULT_COMMAND="rg --files"
fi
