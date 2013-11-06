#!/bin/bash
DOTFILES="$(pwd)/$(dirname "$0")"
ln -s "$DOTFILES/.bashrc" "$HOME/.bashrc"
ln -s "$DOTFILES/sbt" "$HOME/.sbt"
ln -s "$DOTFILES/vim" "$HOME/.vim"
ln -s "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
ln -s "$DOTFILES/vimperatorrc" "$HOME/.vimperatorrc"
[[ -d "$HOME/.config" ]] || mkdir "$HOME/.config"
ln -s "$DOTFILES/git" "$HOME/.config/git"
