#!/bin/bash

# Password Prompt
zenity --password --title="Easy Bitcoin Wallet Installer" | sudo -S echo ""

# GUI
selection=$(zenity --list --title="Easy Bitcoin Wallet Installer" --text="Select a wallet and click OK." --width=1062 --height=208 \
	--column="Wallet"		--column="Description"								--column="Ease of Use"	--column="Security"	--column="Blockchain Download" \
	"Electrum (Recommended)"	"Electrum is an easy to use Bitcoin client."					"Very Easy"		"Very Secure"		No \
	Bitcoin-Qt			"Bitcoin-Qt is a full Bitcoin client and builds the backbone of the network."	Medium			"Very Secure"		"Yes (Over 16GB)" \
	Multibit			"MultiBit is a secure, lightweight, international Bitcoin wallet."		Easy			"Secure"		No \
	Armory				"Armory is taking Bitcoin security and usability to the next level."		Hard			"Very Secure"		"Yes (over 16GB)" \
);

# Tasks
if [ "$selection" = "Electrum (Recommended)" ]; then
	notify-send "Installing Electrum" "Please wait."
	sudo apt-get -y install python-qt4 python-pip
	sudo apt-get -y install python-slowaes
	sudo pip install http://download.electrum.org/Electrum-1.9.5.tar.gz#md5=e8d66b08f7d1d745e1de04a090d199c2
	notify-send "Installation finished" "You can find Electrum by typing it's name in the upper left menu."
elif [ "$selection" = "Bitcoin-Qt" ]; then
	notify-send "Installing Bitcoin-Qt" "Please wait."
	sudo add-apt-repository -y ppa:bitcoin/bitcoin
	sudo apt-get -y update
	sudo apt-get -y install bitcoin-qt
	notify-send "Installation finished" "You can find Bitcoin-Qt by typing it's name in the upper left menu."
elif [ "$selection" = "Multibit" ]; then
	notify-send "Installing Multibeat" "Please wait."
	wget -O /tmp/multibit-0.5.15-linux.jar https://multibit.org/releases/multibit-0.5.15/multibit-0.5.15-linux.jar
	sudo apt-get install -y default-jre
	chmod +x /tmp/multibit-0.5.15-linux.jar
	java -jar /tmp/multibit-0.5.15-linux.jar
	notify-send "Installation finished" "You can find Multibit by typing it's name in the upper left menu."
elif [ "$selection" = "Armory" ]; then
	notify-send "Installing Armory" "Please wait."
	sudo add-apt-repository -y ppa:bitcoin/bitcoin
	sudo apt-get -y update
	sudo apt-get -y install bitcoin-qt bitcoind
	if [ "$(uname -m)" = "i686" ]; then
		wget -O /tmp/armory_0.90-beta_12.04_i386.deb https://s3.amazonaws.com/bitcoinarmory-releases/armory_0.90-beta_12.04_i386.deb
		sudo dpkg -i /tmp/armory_0.90-beta_12.04_i386.deb
	elif [ "$(uname -m)" = "x86_64" ]; then
		wget -O /tmp/armory_0.90-beta_12.04_amd64.deb https://s3.amazonaws.com/bitcoinarmory-releases/armory_0.90-beta_12.04_amd64.deb
		sudo dpkg -i /tmp/armory_0.90-beta_12.04_amd64.deb
	fi
	sudo apt-get -f -y install
	notify-send "Installation finished" "You can find Armory by typing it's name in the upper left menu."
fi
