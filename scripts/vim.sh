# Globals 

export SAVE_PLACE=`pwd`

echo "Installing Vim!"
brew install vim

cd $HOME
if [[ -d '.vim' ]]; then
    rm -rf .vim
fi

git clone git@github.com:nmaswood/.vim.git
ln -s $HOME/.vim/.vimrc $HOME/.vimrc

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

vim +PlugInstall
