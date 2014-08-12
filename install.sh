#!/bin/bash
DOTFILES="$(pwd)/$(dirname "$0")"
ln -s "$DOTFILES/.bashrc" "$HOME/.bashrc"
ln -s "$DOTFILES/sbt" "$HOME/.sbt"
ln -s "$DOTFILES/vim" "$HOME/.vim"
ln -s "$DOTFILES/vim/vimrc" "$HOME/.vimrc"
ln -s "$DOTFILES/vimperatorrc" "$HOME/.vimperatorrc"
[[ -d "$HOME/.config" ]] || mkdir "$HOME/.config"
ln -s "$DOTFILES/git" "$HOME/.config/git"
ln -s "$DOTFILES/.ideavimrc" "$HOME/.ideavimrc"

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
