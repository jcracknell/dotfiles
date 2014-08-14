# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias read='read -r'

export EDITOR=vim
export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

if [ $(echo $LANG | grep UTF) ]; then
  export __ps1_sym_branch='\xEE\x82\xA0'
  export __ps1_sym_sep='\xEE\x82\xB0'
  export __ps1_sym_ro='\xEE\x82\xA2'
else
  export __ps1_sym_branch=''
  export __ps1_sym_sep='>'
  export __ps1_sym_ro=''
fi

function __ps1_e() {
  # Bash maps non-printing delimiters \[ and \] in PS1 to \001 and \002 respectively
  echo -ne "\\001\\e[${1}m\002"
}

function __ps1() {
  # If we are in a  git repository, get the absolute path to the root
  __ps1_git_root=$(git rev-parse --show-toplevel 2>/dev/null)

  echo -ne "$(__ps1_e '0;44') $1@$2 "
  if [ $__ps1_git_root ]; then
    # Get the repository name from the root path
    __ps1_git_repo=${__ps1_git_root##*/}
    __ps1_git_repo=${__ps1_git_repo%%.git}
    # Get the branch name or detached ref
    __ps1_git_branch=$(git branch 2>/dev/null | grep '^*' | sed -r 's/\(detached (([^ ]+) ?)+\)/\2/g' | cut -d ' ' -f 2)
    # Display an asterix to indicate if the repository is not pristine
    __ps1_git_status=$(git status --porcelain 2>/dev/null | cut -c 1,2 | grep '[^ !?]' | head -n 1 | sed -r 's/.+/*/g')

    echo -ne "$(__ps1_e '34;45')${__ps1_sym_sep}$(__ps1_e '0;45') "
    if [ $__ps1_sym_branch ]; then
      echo -ne "${__ps1_sym_branch} "
    fi
    # If we are not at the root of the repository, then display the repository name
    if [ "$__ps1_git_root" != "$PWD" ]; then
      echo -ne "${__ps1_git_repo}@"
    fi
    echo -ne "$(__ps1_e '1')${__ps1_git_branch}${__ps1_git_status} $(__ps1_e '0;35;44')${__ps1_sym_sep} $(__ps1_e '0;44')"
  fi
  # Display a read-only indicator if the working directory is not writable
  if [ ! -w "$PWD" -a $__ps1_sym_ro ]; then
    echo -ne "${__ps1_sym_ro} "
  fi
  echo -ne "$(__ps1_e '1')$3 $(__ps1_e '0;34')${__ps1_sym_sep}$(__ps1_e '0') "
}

function __ps2() {
  echo -ne "$(__ps1_e '0;44') + $(__ps1_e '0;34')${__ps1_sym_sep}$(__ps1_e '0') "
}


export -f __ps1
export -f __ps2
export -f __ps1_e
export PS1='$(__ps1 "\u" "\h" "\W")'
export PS2='$(__ps2)'


if [ -f ~/.bashrc.local ]; then
  . ~/.bashrc.local
fi
