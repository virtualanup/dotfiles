fish_vi_key_bindings
function fish_user_key_bindings
    bind -M insert jk "if commandline -P; commandline -f cancel; else; set fish_bind_mode default; commandline -f backward-char force-repaint; end"
end

fish_vi_key_bindings
fzf_key_bindings

eval (python -m virtualfish)
if set -q VIRTUAL_ENV
    echo -n -s (set_color -b blue white) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
end
alias vim="nvim"
alias vi="nvim"
alias gst="git status"
alias tls="tmux ls"
alias tat="tmux attach -t "
alias gp="git push"
alias gcd="git checkout develop"
alias gcm="git checkout master"
alias glgga="git log --graph --decorate --all"
