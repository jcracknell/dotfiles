@echo off
set DOTFILES=%~dp0
mklink /D "%USERPROFILE%\vimfiles" "%DOTFILES%vim"
mklink "%USERPROFILE%\.vimrc" "%DOTFILES%vim\vimrc"
mklink "%USERPROFILE%\.gvimrc" "%DOTFILES%vim\gvimrc"
