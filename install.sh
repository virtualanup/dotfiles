git submodule update --init --recursive
mv ~/.config/nvim ~/.config/oldnvim
mv ~/.tmux.conf ~/.oldtmux.conf
ln -s $PWD/.nvim ~/.config/nvim
ln -s $PWD/.tmux.conf ~/.tmux.conf
