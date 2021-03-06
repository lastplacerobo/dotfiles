# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions


# Unlimted HISTSIZE and HISTFILESIZE, and no duplicates
HISTSIZE=
HISTFILESIZE=
# Ignoredups and space
HISTCONTROL=ignoreboth

# Tab completion non case sensitive and show all matches
bind 'set completion-ignore-case on'
bind 'set show-all-if-ambiguous on'

# Set up prompt nicely
export PS1='\[\e[1;30m\]\t`if [ $? = 0 ]; then echo "\[\e[32m\] ✔ "; else echo "\[\e[31m\] ✘ "; fi`\[\e[0;36m\]\u\[\e[0m\]@\h \[\e[1;34m\]\w \$\[\e[0m\] '


#Misc.
export EDITOR='vim'
export LANG=en_US.UTF-8
alias ll='ls -ahlF --color=auto'
alias grep="/bin/grep --color=auto"

#Enable ctr + s backward search
stty -ixon

#checks the window size after each command and, if necessary, updates the values of LINES and COLUMNS
shopt -s checkwinsize
# append to the history file, don't overwrite it
shopt -s histappend

# Source gitprompt,
if [[ -f ~/.bash-git-prompt/gitprompt.sh ]]; then
  source ~/.bash-git-prompt/gitprompt.sh
  GIT_PROMPT_ONLY_IN_REPO=1
fi
