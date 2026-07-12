# Copyright (c) 2026 Timothy Rost
# SPDX-License-Identifier: MIT

. /etc/ksh.kshrc

alias vi=/usr/local/bin/vim
alias dot="/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

if [ -z "$VISUAL" -a -z "$EDITOR" ]; then
    set -o vi
fi 

# Append PNPM_HOME to PATH
export PNPM_HOME="/home/tim/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PATH:$PNPM_HOME" ;;
esac
