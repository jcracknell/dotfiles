#!/bin/bash
DOTFILES="$(pwd)/$(dirname "$0")"

[[ -d "$HOME/.config" ]] || mkdir "$HOME/.config"

function link() { 
  [ -d "$(dirname "$1")" ] || mkdir -p "$(dirname "$1")"
  [ -f "$1" -o -d "$1" ] || ln -s "$0" "$1"
}

link "$DOTFILES/.bashrc"      "$HOME/.bashrc"
link "$DOTFILES/sbt"          "$HOME/.sbt"
link "$DOTFILES/vim"          "$HOME/.vim"
link "$DOTFILES/vim/vimrc"    "$HOME/.vimrc"
link "$DOTFILES/vimperatorrc" "$HOME/.vimperatorrc"
link "$DOTFILES/.ideavimrc"   "$HOME/.ideavimrc"

# Ensure that the primary user configuration file exists so that host-specific global settings are
# written to in
[[ -f "$HOME/.gitconfig" ]] || touch "$HOME/.gitconfig"
link "$DOTFILES/git"          "$HOME/.config/git"

fontArchives=(
  http://openfontlibrary.org/assets/downloads/cousine/e64962b5515c2e41b8cd473d0113be51/cousine.zip
  http://openfontlibrary.org/assets/downloads/fantasque-sans-mono/db52617ba875d08cbd8e080ca3d9f756/fantasque-sans-mono.zip
  http://font.ubuntu.com/download/ubuntu-font-family-0.80.zip
)

for url in ${fontArchives[@]}; do
  fontDir="$HOME/.local/share/fonts"
  archive="/tmp/$(basename "$url")"

  echo $url
  curl -# -o $archive $url

  if [ ! -d "$fontDir" ]; then mkdir -p "$fontDir"; fi
  
  case ${url##*.} in
    gz) tar -xv -f "$archive" --directory "$fontDir" --transform='s/.*\///g' --wildcards **.ttf ;;
    zip) unzip -u -j "$archive" -d "$fontDir" **.ttf ;;
  esac

  rm "$archive"
done

fc-cache -fv
