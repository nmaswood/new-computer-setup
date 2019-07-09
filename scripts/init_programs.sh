set -u

if [ -z `command -v "brew"` ]; then
    echo "brew is not intalled. installing brew."
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

brew cask install iterm2

for program in fzf htop httpie jq ripgrep tree watch python3
do
    if  brew ls --versions $program > /dev/null; then
        echo "$program is already installed"
    else
        brew install $program
    fi
done
