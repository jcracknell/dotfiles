#!/bin/bash
DOTFILES="$(pwd)/$(dirname "$0")"
ln -s "$DOTFILES/sbt" "$HOME/.sbt"
ln -s "$DOTFILES/vim" "$HOME/.vim"
ln -s "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
ln -s "$DOTFILES/vimperatorrc" "$HOME/.vimperatorrc"
