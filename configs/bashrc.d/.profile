# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/cargo./bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

# fzf - fuzzy search
if [ -d "$HOME/.tools/fzf/bin" ]; then
  export PATH="$HOME/.tools/fzf/bin:$PATH"
fi
