git submodule update --init --recursive
mv ~/.config/nvim ~/.config/oldnvim
ln -s $PWD/.nvim ~/.config/nvim
