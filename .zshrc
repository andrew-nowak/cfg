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

export HOMEBREW_NO_ANALYTICS=1

[ -d "$HOME/.config/zsh/functions" ] && export fpath=("$HOME/.config/zsh/functions" $fpath)

[ -d "/usr/local/bin" ] && export PATH="/usr/local/bin:$PATH"
[ -d "/opt/homebrew/bin" ] && export PATH="/opt/homebrew/bin:$PATH"

# prompt
eval "$(starship init zsh)"

#setup keys
source $HOME/.zsh_keys

# aliases
source $HOME/.zsh_aliases

export EDITOR='nvim'
export VISUAL='nvim'

###################
# Dev environment #

# Fixes for homebrew doing homebrew things
#[ -d "/usr/local/opt/openssl/bin" ] && export PATH="/usr/local/opt/openssl/bin:$PATH"

[ -d "/usr/local/opt/coreutils/libexec/gnubin" ] && export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"
[ -d "/usr/local/opt/coreutils/libexec/gnuman" ] && export MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

[ -d "/usr/local/opt/curl/bin" ] && export PATH="/usr/local/opt/curl/bin:$PATH"

[ -d "/usr/local/opt/python/libexec/bin" ] && export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Programming language version management

# fnm
if >/dev/null 2>/dev/null which fnm; then
  eval "$(fnm env --use-on-cd --version-file-strategy recursive)"
  # not a perfect replacement, but close enough
  alias nvm=fnm

  fnmig_dir="$HOME/.fnmig-bin"

  has_fnmig_dir() {
    [ -d "$fnmig_dir" ]
  }

  has_fnmig_alias() {
    >/dev/null 2>/dev/null fnm exec --using=global node --version
  }

  if has_fnmig_dir; then
    export PATH="$HOME/.fnmig-bin:$PATH"
  fi

  # fnmig: making `npm install -g` work with frequently switch node versions with `fnm`
  #
  # unfortunately some tools (IME, commonly lsp servers) recommend installing with `npm i -g`.
  # but when using fnm, that will install with the _currently active_ npm. when you switch node versions
  # (either by upgrading, or moving into a project that uses a different version) the tool is no longer
  # visible.
  # `fnmig` instead encourages creation of a "global" fnm alias, and then replaces `npm i -g`. When a
  # package containing binaries is installed using `fnmig`, it will be installed using the "global" alias,
  # and a short script for each binary will be dropped into $fnmig_dir, correctly calling `fnm exec` for
  # the corresponding binary and forwarding args
  fnmig() {
    if ! has_fnmig_dir; then
      >&2 echo "fnmig: please create directory $fnmig_dir first!"
      return 2
    elif ! has_fnmig_alias; then
      >&2 echo "fnmig: please setup 'global' alias in fnm first!"
      >&2 echo '  eg. `fnm alias 16 global`'
      return 3
    fi

    if [ "$1" = "updateto" -a -n "$2" ]; then
      local packages=$(fnm exec --using=global npm list -g -p --depth=0 2>/dev/null | tail -n +2 | rev | cut -d '/' -f1 | rev | grep -v -e corepack -e npm)
      echo $packages
      fnm exec --using=$2 npm install -g ${=packages}
      fnm alias $2 global
      return 0
    fi

    fnm exec --using=global npm install -g $1

    for e in $(fnm exec --using=global npm info --json $1 bin | jq -r 'keys[]'); do
      echo >$fnmig_dir/$e '#!/bin/bash'
      echo >>$fnmig_dir/$e "fnm exec --using=global $e "'$@'
      chmod +x $fnmig_dir/$e
    done
  }
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
      /usr/libexec/java_home -V 2>&1 | grep $(uname -p) | awk '{$1=$1};1' | cut -d' ' -f1 -
    fi
  }
  DEFAULT_JDK=1.8
  export JAVA_HOME="$(/usr/libexec/java_home -v$DEFAULT_JDK)"
fi

if 2>&1 >/dev/null which rg ; then
  export FZF_DEFAULT_COMMAND="rg --files"
fi

if [[ "$(uname)" = "Darwin" ]]; then
  GPG_TTY=$(tty)
  export GPG_TTY
fi
