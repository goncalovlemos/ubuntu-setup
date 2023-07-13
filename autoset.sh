#!/bin/sh
sudo apt update

#-- Install curl
application_name="curl"
if dpkg -s "$application_name" >/dev/null 2>&1; then
    echo "Application '$application_name' is installed."
else
    echo "Application '$application_name' is not installed. Installing it."
    sudo apt install curl -y
    echo "Application '$application_name' is installed."
    exit 0
fi

#-- Install wget
application_name="wget"
if dpkg -s "$application_name" >/dev/null 2>&1; then
    echo "Application '$application_name' is installed."
else
    echo "Application '$application_name' is not installed. Installing it."
    sudo apt install wget gpg -y
    echo "Application '$application_name' is installed."
    exit 0
fi

#-- Install git
application_name="git"
if dpkg -s "$application_name" >/dev/null 2>&1; then
    echo "Application '$application_name' is installed."
else
    echo "Application '$application_name' is not installed. Installing it."
    sudo apt install git-all
    echo "Application '$application_name' is installed."
    exit 0
fi

#-- Install Brave Browser
application_name="brave-browser"
if dpkg -s "$application_name" >/dev/null 2>&1; then
    echo "Application '$application_name' is installed."
else
    echo "Application '$application_name' is not installed. Installing it."
    sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
    echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser -y
    echo "Application '$application_name' is installed."
    exit 0
fi

#-- Install VSCode
application_name="code"
if dpkg -s "$application_name" >/dev/null 2>&1; then
    echo "Application '$application_name' is installed."
else
    echo "Application '$application_name' is not installed. Installing it."
    wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
    sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
    sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
    rm -f packages.microsoft.gpg
    sudo apt install apt-transport-https
    sudo apt update
    sudo apt install code
    echo "Application '$application_name' is installed."
    exit 0
fi

#-- Install Spotify
application_name="spotify-client"
if dpkg -s "$application_name" >/dev/null 2>&1; then
    echo "Application '$application_name' is installed."
else
    echo "Application '$application_name' is not installed. Installing it."
    curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
    echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
    sudo apt update && sudo apt install spotify-client -y
    echo "Application '$application_name' is installed."
    exit 0
fi

#-- Install discord
application_name="discord"
if dpkg -s "$application_name" >/dev/null 2>&1; then
    echo "Application '$application_name' is installed."
else
    echo "Application '$application_name' is not installed. Installing it."
    wget -O ~/discord.deb "https://discord.com/api/download?platform=linux&format=deb"
    sudo dpkg -i ~/discord.deb
    sudo apt -f install discord -y
    rm ~/discord.deb
    echo "Application '$application_name' is installed."
    exit 0
fi

#-- Install Extension Manager
application_name="extension-manager"
if dpkg -s "$application_name" >/dev/null 2>&1; then
    echo "Application '$application_name' is installed."
else
    sudo apt install gnome-shell-extension-manager -y
    exit 0
fi

#-- Install Gnome Tweaks
application_name="gnome-tweaks"
if dpkg -s "$application_name" >/dev/null 2>&1; then
    echo "Application '$application_name' is installed."
else
    sudo apt install gnome-tweaks -y
    exit 0
fi

#-- Hide mounted drives from panel
current_setting=$(gsettings get org.gnome.shell.extensions.dash-to-dock show-mounts)
if [[ "$current_setting" == "false" ]]; then
    echo "Mounted devices icon is already hidden."
    exit 0
else
    gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
    echo "Mounted devicesn icon has been hidden."
fi

#-- Hide trash from panel
current_setting=$(gsettings get org.gnome.shell.extensions.dash-to-dock show-trash)
if [[ "$current_setting" == "false" ]]; then
    echo "Trash icon is already hidden."
    exit 0
else
    gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false
    echo "Trash icon has been hidden."
fi

#-- Hide desktop icons
current_setting=$(gsettings get org.gnome.desktop.background show-desktop-icons)
if [[ "$current_setting" == "false" ]]; then
    echo "Desktop icons are already hidden."
    exit 0
else
    gsettings set org.gnome.desktop.background show-desktop-icons false
    echo "Desktop icons have been hidden."
fi

#-- Set the GTK theme to Yaru Dark
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-dark"

#-- Set the icon theme to Yaru Dark
gsettings set org.gnome.desktop.interface icon-theme "Yaru-dark"

#-- Set the cursor theme to DMZ-Black
gsettings set org.gnome.desktop.interface cursor-theme "DMZ-Black"

#-- Enable seconds in the clock
gsettings set org.gnome.desktop.interface clock-show-seconds true

#-- Enable weekday in the clock
gsettings set org.gnome.desktop.interface clock-show-weekday true

#-- Enable week numbers in the calendar
gsettings set org.gnome.desktop.calendar show-weekdate true

#-- Hide Home icon from desktop
gsettings set org.gnome.shell.extensions.ding show-home false

#-- Disable Ubuntu Dock
gnome-extensions disable ubuntu-dock@ubuntu.com


