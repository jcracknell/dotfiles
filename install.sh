#!/bin/bash
DOTFILES="$(pwd)/$(dirname "$0")"
ln -s "$DOTFILES/vim" "$HOME/.vim"
ln -s "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
