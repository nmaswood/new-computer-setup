set -u

SAVE_SPOT=`pwd`
cd $HOME
git clone git@github.com:nmaswood/zshrc.git

if [ -z `command -v "zsh"` ]; then
    echo "zsh is not intalled. installing zsh."
    brew install zsh zsh-completions
    echo "setting zsh as default"
    chsh -s $(which zsh)
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

if [[ -d "$HOME/.oh-my-zsh" ]]; then
    rm .zshrc
fi

ln -s zshrc/.zshrc .zshrc
