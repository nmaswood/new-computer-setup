cd $HOME

if [ ! -d "$HOME/zshrc" ]; then
    echo "zshrc directory does not exist"
    exit 1
fi

if [ -f "$HOME/.gitconfig" ]; then
    echo "renaming .gitconfig"
    mv .gitconfig .old-gitconfig
fi

ln -s zshrc/.gitconfig .gitconfig

export CONFIG_FILE=$(cat <<-END
Host *
  AddKeysToAgent yes
  UseKeychain yes
  IdentityFile ~/.ssh/id_rsa
END)

if [ ! -d "$HOME/.ssh" ]; then 
	echo "No folder detected creating ssh key."
	ssh-keygen -t rsa -b 4096 -C "nasr@ironcladapp.com"
	eval "$(ssh-agent -s)"
	if [ ! -f ~/.ssh/config ]; then
	    echo "Writing ssh config file"
	    cat $CONFIG_FILE > ~/.ssh/config
	else
	  echo "Config file already exists"
	fi
	ssh-add -K ~/.ssh/id_rsa
else
	echo ".ssh folder detected not creating ssh key."
fi


echo "copying ssh key to clipboard"

if [ ! -f "$HOME/.ssh/id_rsa.pub" ]; then
    echo "Warning a key file was not added to .ssh"
    exit 1 
fi

echo "It's in your clipboard"
pbcopy < ~/.ssh/id_rsa.pub
read -p "Type 'go' and press enter for github, else just type enter"$'\n' key

if [ "$key" == "go" ]; then
	open "https://github.com/settings/ssh/new"
fi
