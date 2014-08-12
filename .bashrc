#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'

export _JAVA_OPTIONS='-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true'

if [ -f "$(dirname "$0")/.bashrc.local" ]; then
  . "$(dirname "$0")/.bashrc.local";
fi

function __ps1_git() {
  # Get the branch name or detached ref
  __ps1_git_branch=$(git branch 2>/dev/null | grep '^*' | sed -r 's/\((([^ ]+) ?)+\)/\2/g' | cut -d ' ' -f 2)
  # Display an asterix to indicate if the repository is not pristine
  __ps1_git_status=$(git status --porcelain 2>/dev/null | cut -c 1,2 | grep '[^!?]' | head -n 1 | sed -r 's/.+/*/g')


  if [ $__ps1_git_branch ]; then
    echo -ne "[\\033[1;34m${__ps1_git_branch}${__ps1_git_status}\\033[0;34m]"
  fi
}

export -f __ps1_git
export PS1='\033[0;34m[\u@\h \033[1;34m\W\033[0;34m]$(__ps1_git)$\033[0m '
