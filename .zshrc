# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="avit"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

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
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

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
export EDITOR="nvim"

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

# vim keybindings
# bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

# Use  jk to exit insert mode
bindkey jk vi-cmd-mode

alias rg="ranger"
alias tls="tmux ls"
alias tat="tmux attach -t "
alias cat="ccat"

alias vi="nvim"
alias vim="nvim"
alias co="git checkout"

if [ -e /usr/bin/python3 ]
then
VIRTUALENVWRAPPER_PYTHON='/usr/bin/python3'
fi

if [ -e /usr/local/bin/python3 ]
then
VIRTUALENVWRAPPER_PYTHON='/usr/local/bin/python3'
fi

if [ -e /usr/bin/virtualenvwrapper.sh ]
then
    export WORKON_HOME=~/.virtualenvs
    source /usr/bin/virtualenvwrapper.sh
fi

if [ -e /usr/local/bin/virtualenvwrapper.sh ]
then
    export WORKON_HOME=~/.virtualenvs
    source /usr/local/bin/virtualenvwrapper.sh
fi


[ -f ~/.localzshrc ] && source ~/.localzshrc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#Plugins
if hash antibody 2>/dev/null; then
    source <(antibody init)
    antibody bundle < ~/.config/zsh/.zsh_plugins
fi

#if ! pgrep -u "$USER" ssh-agent > /dev/null; then
#    ssh-agent > ~/.config/.ssh-agent-thing
#    # Don't echo anything
#    head -n 2 ~/.config/.ssh-agent-thing > ~/.config/.ssh-agent-thing.tmp
#    mv ~/.config/.ssh-agent-thing.tmp ~/.config/.ssh-agent-thing

#fi
#if [[ ! "$SSH_AUTH_SOCK" ]]; then
#    eval "$(<~/.config/.ssh-agent-thing)"
#fi
#

function attach-or-create-tmux-session() {
    local project_path=$1

    # Obtain the session name to use
    local name=$(basename $project_path)

    # Check if session exists-stores status in exit code
    tmux has-session -t $name
    local tmux_status=$?

    # Attach and return if the session is present
    if [ "${tmux_status}" = "0" ]; then
        echo "Session found"
        tmux attach-session -t $name
        return
    fi

    # Create new session
    tmux new-session -d -c $project_path -s $name
    tmux send-keys "nvim -S ~/.vim_sessions/${name}" C-m
    tmux rename-window -t $name:1 'nvim'

    # Open zsh windows
    tmux new-window -a -c $project_path -t $name:1 -n "zsh1"
    tmux new-window -a -c $project_path -t $name:2 -n "zsh2"

    # Open ranger
    tmux new-window -a -c $project_path -t $name:3 -n "ranger"
    tmux send-keys "ranger" C-m

    # Focus on editor window
    tmux select-window -t $name:1

    # Attach the tmux session created
    tmux attach-session -t $name
}


alias tmuxf="attach-or-create-tmux-session"
