if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


# Aliases
alias l="ls -F"
#alias ll="ls -AGlFth"
alias ll="ls -alh"
alias ltr="ls -latr | tail"
alias grep='grep --color=auto'
alias df='df -H'
alias fig='find . | grep'
alias reload="source ~/.zshrc"
alias netest="ping 8.8.8.8"
alias simplewebserver="python -m SimpleHTTPServer 9000"
alias slytherin='mosh slytherin -- tmux attach -d || tmux new'
alias -g lastm='*(om[1])'

# Python
if command -v ipython > /dev/null; then
    alias python="ipython"
fi
if command -v ipython3 > /dev/null; then
    alias python3="ipython3"
fi
export PYTHONSTARTUP=$HOME/.pythonrc

# Suffix aliases
alias -s log=less
alias -s html=open

# Important files
alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias vimlast="vim -c \"normal '0\""
alias syslog="vim /var/log/syslog"
alias devdocs="open http://devdocs.io"

# Shorthands
alias e="exit"
alias h='history -fd -500'
alias hgrep='history -fd 0 | grep'
alias sr='ssh -l root'

# cd & ls
alias lc="cl"
cl() {
   if [ -d "$1" ]; then
      cd "$1"
      l
   fi
}

# mkdir & ls
alias cm="mc"
mc() {
    mkdir -p "$*" && cd "$*" && pwd
}

# Analyze history data
analyze_history(){
    cut -f2 -d";" ~/.zsh_history | sort | uniq -c | sort -nr | head -n 30
}
analyze_commands(){
    cut -f2 -d";" ~/.zsh_history | cut -d' ' -f1 | sort | uniq -c | sort -nr | head -n 30
}

# Exports
export EDITOR="nano"
export LC_ALL="en_US.UTF-8"
export LANG="en_US"
export PATH=/usr/local/bin:$PATH # Brew path
export PATH=/usr/local/sbin:$PATH # Brew second path
export PATH=$PATH:$HOME/dotfiles/scripts
export PATH=$PATH:$HOME/Projects/git-jira-tools
export TERM='xterm-256color'

# Remove annoying messages
unsetopt correctall

# FASD for faster switching between directories
#eval "$(fasd --init auto)"
#alias v='f -e vim'

# alt-left and alt-right for switching words in terminal
# taken from https://github.com/solnic/dotfiles/blob/master/home/zsh/key-bindings.zsh
bindkey -e

bindkey '^H' delete-word # iterm
bindkey '^[[3~' delete-char # tmux

bindkey '^[[1;9D' backward-word # iterm
bindkey '^[^[[D' backward-word # tmux os x
bindkey '^[[1;3D' backward-word # tmux ubuntu

bindkey '^[[1;9C' forward-word # iterm
bindkey '^[^[[C' forward-word # tmux os x
bindkey '^[[1;3C' forward-word # tmux ubuntu

# History configurations
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_VERIFY
setopt SHARE_HISTORY # share history between sessions
setopt EXTENDED_HISTORY # add timestamps to history
setopt APPEND_HISTORY # adds history
setopt INC_APPEND_HISTORY SHARE_HISTORY  # adds history incrementally and share it across sessions
setopt HIST_IGNORE_ALL_DUPS  # don't record dupes in history
setopt HIST_REDUCE_BLANKS
setopt interactivecomments # allow # in a comment

kube_prompt()
{
   kubectl_current_context=$(kubectl config current-context)
   kubectl_project=$(echo $kubectl_current_context | cut -d '_' -f 2)
   kubectl_cluster=$(echo $kubectl_current_context | cut -d '_' -f 4)
   kubectl_prompt="k8s:($kubectl_project|$kubectl_cluster)"
   echo $kubectl_prompt
}

# Source awscli completion
[ -f /usr/local/share/zsh/site-functions/_aws ] && source /usr/local/share/zsh/site-functions/_aws

# Load scripts per OS
case `uname` in
  Darwin)
    # commands for OS X go here
    echo "OSX system..."
  ;;
  Linux)
    # commands for Linux go here
    echo "Linux system..."
    ~/dotfiles/home/.wacomcplrc.sh
  ;;
esac

# Do a custom prompt stolen from steeeef theme
zstyle ':prezto:module:prompt' theme 'off'
setopt prompt_subst

turquoise="%F{cyan}"
orange="%F{yellow}"
purple="%F{magenta}"
limegreen="%F{green}"
red="%F{red}"
PR_RST="%f"

PROMPT=$'%{$purple%}%n${PR_RST} at %{$orange%}%m${PR_RST} in %{$limegreen%}%~${PR_RST} %{$turquoise%}${PR_RST} $ '
RPROMPT=$'%{$red%}$(kube_prompt)'

# Source configuration for local machine if it exists
[ -f ~/.zshrclocal ] && source ~/.zshrclocal

# test -e ${HOME}/.iterm2_shell_integration.zsh && source ${HOME}/.iterm2_shell_integration.zsh

source /usr/local/bin/virtualenvwrapper.sh

setopt promptsubst


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
