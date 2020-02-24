#bash completion
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

#git promot
source ~/.git-prompt.sh
export PS1='[ \u@\h \W\[\033[32m\]$(__git_ps1 " (%s)")\[\033[00m\] ]\$ '

#aliases
source ~/.bash_aliases

#app setup
source ~/.my_app_setup
