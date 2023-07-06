#!/usr/bin/env bash
set -e


if sudo -u wgoeman fc-list | grep -q 'Nerd Font'; then
    echo -e "\e[32mA Nerd Font seems to be present\e[0m"
else
    echo -e "\e[31mIt looks like no Nerd Font is installed. Download and install 'Fira Code Nerd Font' (or whatever is your preference). These are not in the apt repos.\e[0m"
    exit 1
fi

if [ -z "$SUDO_USER" ]; 
then
    echo -e "\e[31mThis script must be run as root\e[0m"
    exit 1
fi

# Add docker apt repo
if [ -f /etc/apt/sources.list.d/docker.list ]
then
    echo -e "\e[32mDocker apt sources already configured\e[0m"
else
    echo -e "\e[35mConfiguring docker apt repos\e[0m"
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    chmod a+r /etc/apt/keyrings/docker.gpg

    echo \
    "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
    "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
    tee /etc/apt/sources.list.d/docker.list > /dev/null
    chmod a+r /etc/apt/sources.list.d/docker.list
fi


# Add i3wm repo
if [ -f /etc/apt/sources.list.d/sur5r-i3.list ]
then
    echo -e "\e[32mi3wm apt sources already configured\e[0m"
else
    echo -e "\e[35mConfiguring i3wm apt repos\e[0m"
    pushd /tmp
    /usr/lib/apt/apt-helper download-file https://debian.sur5r.net/i3/pool/main/s/sur5r-keyring/sur5r-keyring_2023.02.18_all.deb keyring.deb SHA256:a511ac5f10cd811f8a4ca44d665f2fa1add7a9f09bef238cdfad8461f5239cc4
    apt install ./keyring.deb
    popd
    echo "deb http://debian.sur5r.net/i3/ $(grep '^DISTRIB_CODENAME=' /etc/lsb-release | cut -f2 -d=) universe" | tee /etc/apt/sources.list.d/sur5r-i3.list
    chmod a+r /etc/apt/sources.list.d/sur5r-i3.list
fi


# Install all custom packages
apt update
apt install \
    autorandr \
    fish \
    i3 \
    polybar \
    kitty \
    openconnect \
    network-manager-openconnect \
    network-manager-openconnect-gnome \
    fonts-firacode \
    fonts-font-awesome \
    fonts-material-design-icons-iconfont \
    pass \
    pavucontrol \
    arandr \
    jq \
    podman \
    bat \
    docker-ce docker-ce-cli \
    pip \
    blueman \
    rofi \
    golang \
    xdotool \
    ripgrep \
    flameshot \
    nitrogen

if [ -z "$GOPROXY" ]
then
    echo -e "\e[33m\$GOPROXY is not set! Consider set it up for custom repository access.\e[0m"
fi
    
PIP_CONF_PATH=/home/$SUDO_USER/.config/pip/pip.conf
if [ ! -f "$PIP_CONF_PATH" ]
then
    echo -e "\e[33mPyhton/pip is installed, but not configured. Create a file at $PIP_CONF_PATH to setup a custom repository!\e[0m"
else
    echo -e "\e[32mPyhton/pip is already configured\e[0m"
fi

sudo -u "$SUDO_USER" pip install rofimoji

echo -e "\e[35mSwitching shell to fish\e[0m" 
chsh "$SUDO_USER" -s /usr/bin/fish

if [ ! -f /usr/local/bin/starship ]
then 
    echo -e "\e[35mInstalling starship prompt\e[0m" 
    curl -sS https://starship.rs/install.sh | sh
else
    echo -e "\e[32mStarship prompt already installed\e[0m" 
fi

echo -e "\e[32mDone!\e[0m" 