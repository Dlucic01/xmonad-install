#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias killyourself='echo | sudo shutdown now'
alias goodnight='echo | sudo shutdown now'
alias parrot='echo | curl parrot.live'
alias moon='echo | curl wttr.in/moon'
alias luck='echo | cowsay pluck'
alias ls='ls --color=auto'

PS1='[\u@\h \W]\$ '
