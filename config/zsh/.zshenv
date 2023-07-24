export CLICOLOR=1
export TERM=xterm-256color

# Python
if [ -f "$HOME/.pythonrc" ] ; then
  export PYTHONSTARTUP=$HOME/.pythonrc  
fi
