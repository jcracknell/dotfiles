# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias read='read -r'

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

function __ps1_e() {
  # Bash maps non-printing delimiters \[ and \] in PS1 to \001 and \002 respectively
  echo -ne "\\001\\e[${1}m\002"
}

function __ps1() {
  __ps1_utf=$(echo $LANG | grep UTF)

  __ps1_sym_branch=$([ $__ps1_utf -a $__ps1_powerline ] && echo -e '\xEE\x82\xA0')
  __ps1_sym_sep=$([ $__ps1_utf -a $__ps1_powerline ] && echo -e '\xEE\x82\xB0'  || echo '>')
  __ps1_sym_ro=$([ $__ps1_utf -a $__ps1_powerline ] && echo -e '\xEE\x82\xA2')

  # Get the branch name or detached ref
  __ps1_git_branch=$(git branch 2>/dev/null | grep '^*' | sed -r 's/\(detached (([^ ]+) ?)+\)/\2/g' | cut -d ' ' -f 2)
  # Display an asterix to indicate if the repository is not pristine
  __ps1_git_status=$(git status --porcelain 2>/dev/null | cut -c 1,2 | grep '[^ !?]' | head -n 1 | sed -r 's/.+/*/g')

  echo -ne "$(__ps1_e '0;44') $1@$2 "
  # Display a read-only indicator if the working directory is not writable
  if [ ! -w "$PWD" -a $__ps1_sym_ro ]; then
    echo -ne "${__ps1_sym_ro} "
  fi
  echo -ne "$(__ps1_e '1')$3 $(__ps1_e '0;34')"
  if [ $__ps1_git_branch ]; then
    echo -ne "$(__ps1_e '45')${__ps1_sym_sep}$(__ps1_e '0;45') "
    if [ $__ps1_sym_branch ]; then
      echo -ne "${__ps1_sym_branch} "
    fi
    echo -ne "$(__ps1_e '1')${__ps1_git_branch}${__ps1_git_status} $(__ps1_e '0;35')"
  fi
  echo -ne "${__ps1_sym_sep}$(__ps1_e '0') "
}

export -f __ps1
export -f __ps1_e
export __ps1_powerline=1
export PS1='$(__ps1 "\u" "\h" "\W")'

if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi
