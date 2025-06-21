# Copyright (c) 2025 Timothy Rost
# SPDX-License-Identifier: MIT

. /etc/ksh.kshrc

alias vi=/usr/local/bin/vim
alias dot="/usr/local/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

if [ -z "$VISUAL" -a -z "$EDITOR" ]; then
    set -o vi
fi 
