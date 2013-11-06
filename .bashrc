#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

if [ -f "$(dirname "$0")/.bashrc.local" ]; then
  . "$(dirname "$0")/.bashrc.local";
fi
