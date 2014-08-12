# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

function __ps1() {
  # Get the branch name or detached ref
  __ps1_git_branch=$(git branch 2>/dev/null | grep '^*' | sed -r 's/\(detached (([^ ]+) ?)+\)/\2/g' | cut -d ' ' -f 2)
  # Display an asterix to indicate if the repository is not pristine
  __ps1_git_status=$(git status --porcelain 2>/dev/null | cut -c 1,2 | grep '[^ !?]' | head -n 1 | sed -r 's/.+/*/g')

  __ps1_sym_branch=$([ $__ps1_powerline ] && echo -e '\xEE\x82\xA0 ' || echo '' )
  __ps1_sym_sep=$([ $__ps1_powerline ] && echo -e '\xEE\x82\xB0'  || echo '>')

  echo -ne "\\e[0;37;44m $1@$2 \\e[1;37m$3 \\e[0;34m"

  if [ $__ps1_git_branch ]; then
    echo -ne "\\e[0;34;45m${__ps1_sym_sep} \\e[0;37;45m${__ps1_sym_branch}\\e[1;37;45m${__ps1_git_branch}${__ps1_git_status} \\e[0;35m"
  fi

  echo -ne "${__ps1_sym_sep}\\e[0m "
}

export -f __ps1
export __ps1_powerline=1
export PS1='$(__ps1 "\u" "\h" "\W")'

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi
