export EDITOR=vim
export PATH=$PATH:$HOME/bin:$HOME/Installers/sbt/bin:/usr/local/go/bin:$HOME/Library/Haskell/bin
export GNUTERM=x11
export MAGICK_HOME=$HOME/Installers/ImageMagick-6.8.9
export PATH=$PATH:$MAGICK_HOME/bin
export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$MAGICK_HOME/lib/
alias gstat='git status'
alias gb='git branch'
alias gco='git checkout'
alias gdiff='git diff'

Color_Off="\[\033[0m\]"
Red="\[\033[0;31m\]"
Green="\[\033[0;32m\]"

export PS1='$(git branch &>/dev/null;\
if [ $? -eq 0 ]; then \
  echo "$(echo `git status` | grep "nothing to commit" > /dev/null 2>&1; \
  if [ "$?" -eq "0" ]; then \
    # Clean repository - nothing to commit
    echo "'$Green'["$(git rev-parse --abbrev-ref HEAD); \
  else \
    # Changes to working tree
    echo "'$Red'["$(git rev-parse --abbrev-ref HEAD); \
  fi)]'$Color_Off' \W \$ "; \
else \
  # Prompt when not in git repo
  echo "\W \$ "; \
fi)'

