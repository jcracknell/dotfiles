#!/bin/bash
DOTFILES="$(pwd)/$(dirname "$0")"

function link() {
	target="$DOTFILES/$1"
	echo "$2 -> $target"
	ln -s "$target" "$2"	
}

link "vim" "$HOME/.vim"
link "vim/vimrc" "$HOME/.vimrc"
link "vim/gvimrc" "$HOME/.gvimrc"
