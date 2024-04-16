# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="mine"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM=~/.zshrc.d

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git colored-man-pages vi-mode common-aliases zsh-autosuggestions zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

ulimit -c unlimited
setopt no_share_history 
stty -ixon

export LOCAL=$HOME/local
export PATH=$LOCAL/bin:$LOCAL/golang/bin:$PATH
export PATH=$(printf %s "$PATH" | awk -vRS=: '!a[$0]++' | paste -s -d:)
export LD_LIBRARY_PATH=$LOCAL/lib
export P4CONFIG=$HOME/.p4rc
export EDITOR=$LOCAL/bin/vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

unalias rm
alias p="ps ux"
alias ll="ls -lht"
alias ip="ifconfig | grep -a 'inet ' | sed -e '/127\.0\.0\.1/d;s/.*inet \([0-9\.]\+\).*/\1/'" 
alias clear-color="sed -r \"s/\\x1B\\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g\""

alias del-log="find -name \"*.log*\" | xargs -r rm"
alias find-exe="find -type f -perm -744 | egrep -v '.sh$'"
# alias update-proto="$HOME/p4/update_proto.sh"
# alias create-module="$LOCAL/templates/create_module.sh"
# alias create-color_coded="$LOCAL/templates/create_color_coded.sh"
# alias update-iplist="$LOCAL/templates/update_iplist.sh"

alias nuget="mono /usr/local/bin/nuget.exe"
alias kubedev="kubectl --kubeconfig=$HOME/.kube/dev_config -n private-server"
alias helmdev="helm --kubeconfig $HOME/.kube/dev_config -n private-server"

# alias make="luit -encoding gbk make"
# alias svn="luit -encoding gbk svn"
setopt complete_aliases

alias -g E="| gbk2utf8"
alias -g C="| cut -c -$COLUMNS"
alias -g EL="E L"
alias -g LL="C L"

simplify-log() { sed -u 's/^.*\['$1'd\][^]]*\] //' }
tail-log() { tail -f $1/log/$1* | egrep --line-buffered --text $2 | simplify-log $1 }


function _reset-prompt-and-accept-line {
    zle reset-prompt
    zle .accept-line     # Note the . meaning the built-in accept-line.
}
zle -N accept-line _reset-prompt-and-accept-line

precmd() { print -Pn "\033]2;%~\033\\" }
export TERM=screen-256color
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=23"

# start typing + [Up-Arrow] - fuzzy find history forward
if [[ "${terminfo[kcuu1]}" != "" ]]; then
    autoload -U up-line-or-beginning-search
    zle -N up-line-or-beginning-search
    bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
# start typing + [Down-Arrow] - fuzzy find history backward
if [[ "${terminfo[kcud1]}" != "" ]]; then
    autoload -U down-line-or-beginning-search
    zle -N down-line-or-beginning-search
    bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi

bindkey "^K" forward-char

# export http_proxy=http://devnet-proxy.oa.com:8080
# export https_proxy=http://devnet-proxy.oa.com:8080
# export no_proxy="tlinux-mirror.tencent-cloud.com,tlinux-mirrorlist.tencent-cloud.com,localhost,mirrors-tlinux.tencentyun.com,mirrors.tencent.com,.oa.com,.woa.com,.local,9.134.52.157,10.240.99.238"

