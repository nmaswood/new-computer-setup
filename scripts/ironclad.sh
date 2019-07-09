# GLOBALS 

set -u

line_break() {
  LINE_BREAK="--------"$'\n'
  echo "$LINE_BREAK"
}

function pause
{
    echo "Press Enter to continue"$'\n'
    read
}

echo "Changing directory to $HOME"
cd $HOME

if [ ! -d "ironclad" ]; then
    echo "Ironclad repo does not exist ... cloning"
    git clone git@github.com:Ironclad-ai/ironclad.git
fi

echo "Changing directory to ironclad"
cd $HOME/ironclad


echo "Installing dev dependencies"

brew cask install osxfuse

for program in kubernetes-cli mongodb mysql socat datawire/blackbird/telepresence yarn
do
    if  brew ls --versions $program > /dev/null; then
        echo "$program is already installed"
    else
        brew install $program
    fi
done

if [[ -z `command -v "hyperkit"` ]]; then
    brew install hyperkit
    curl -LO https://storage.googleapis.com/minikube/releases/latest/docker-machine-driver-hyperkit \
&& sudo install -o root -g wheel -m 4755 docker-machine-driver-hyperkit /usr/local/bin/
fi

brew cask install docker
brew cask install google-cloud-sdk
brew cask install minikube

sudo gem install mustache

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
nvm install lts/dubnium
nvm alias default lts/dubnium

echo "Sign into docker hub"
pause

gcloud init
gcloud auth application-default login

echo "Copy dev.k8s.yml into ironclad directory"
pause

echo "Copy sample_bash_profile and hellosign-api-key into your env"
pause

minikube config set vm-driver hyperkit
minikube start --disk-size 80g --memory 4096

./dev/init dev.k8s.yml
./dev/pull -v develop
