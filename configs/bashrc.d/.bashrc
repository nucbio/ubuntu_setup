#!/bin/bash

# Read .bashrc if shell is interactive
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Note: Probably do not need this because you use modern tools with colors already
# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Source custom *.sh config files from ~/.bashrc.d
if [[ -d "$HOME/.bashrc.d" ]]; then
    while IFS= read -r -d '' file; do
        [[ -r "$file" ]] && source "$file"
    done < <(find "$HOME/.bashrc.d" -type f -name "*.sh" -print0 2>/dev/null)
fi

# fzf - fuzzy search - interactive features
if [ -d "$HOME/.tools/fzf" ]; then
  if [ -f "$HOME/.tools/fzf/shell/key-bindings.bash" ]; then
    source "$HOME/.tools/fzf/shell/key-bindings.bash"
  fi

  if [ -f "$HOME/.tools/fzf/shell/completion.bash" ]; then
    source "$HOME/.tools/fzf/shell/completion.bash"
  fi
fi
