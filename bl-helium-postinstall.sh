#!/bin/bash
########################################################################
#### CONFIG ##########################################################
########################################################################
vb_package="virtualbox-5.2"
ep_url="https://download.virtualbox.org/virtualbox/5.2.12/Oracle_VM_VirtualBox_Extension_Pack-5.2.12.vbox-extpack"   #https://www.virtualbox.org/wiki/Downloads
current_dir="$(dirname "$(readlink -f "$0")")"



[ "$(id -u)" -ne 0 ] && echo "Administrative prvileges needed" && exit 1
read -p "Are you config a laptop (Y/n)? " laptop
########################################################################
#### PACKAGES ##########################################################
########################################################################
apt-get update

# extra packages
read -p "$(echo -e "\n\e[1m\e[4mInstall some useful packages (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  apt-get install -y vim vls ttf-mscorefonts-installer fonts-freefont-ttf
  apt-get install -y haveged                        # Avoid delay first login
fi

# rofi
read -p "$(echo -e "\n\e[1m\e[4mInstall rofi launcher (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  apt-get install -y rofi
  cat "$current_dir"/config/rofi.conf >> /usr/share/bunsen/skel/.Xresources
  ls -d /home/* | xargs -I {} cp /usr/share/bunsen/skel/.Xresources {}/
  xrdb -load /usr/share/bunsen/skel/.Xresources  # ?????????? other users
fi


# PlayOnLinux
read -p "$(echo -e "\n\e[1m\e[4mInstall PlayOnLinux (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  apt-get install -y winbind
  apt-get install -y playonlinux
fi

# VirtualBox
read -p "$(echo -e "\n\e[1m\e[4mInstall VirtualBox and add repositories (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  echo "deb http://download.virtualbox.org/virtualbox/debian stretch contrib" > /etc/apt/sources.list.d/virtualbox.list
  wget -q https://www.virtualbox.org/download/oracle_vbox_2016.asc -O- | sudo apt-key add -
  wget -q https://www.virtualbox.org/download/oracle_vbox.asc -O- | sudo apt-key add -
  apt-get update
  apt-get install -y linux-headers-$(uname -r) "$vb_package"
  # VirtualBox Extension Pack
  read -p "Install Extension Pack (Y/n)? " q
  if [ "${q,,}" != "n" ]; then
    t=$(mktemp -d)
    wget -P "$t" "$ep_url"  
    vboxmanage extpack install --replace "$t"/*extpack
    rm -rf "$t"
  fi
fi

# Sublime Text 3
read -p "$(echo -e "\n\e[1m\e[4mInstall Sublime-Text 3 and add repositories (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
  wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
  apt-get update
  apt-get install sublime-text
  update-alternatives --install /usr/bin/bl-text-editor bl-text-editor /usr/bin/subl 90
  update-alternatives --set bl-text-editor /usr/bin/subl
fi

# Google Chrome
read -p "$(echo -e "\n\e[1m\e[4mInstall Google Chrome and add repositories (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google-chrome.list
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
  apt-get update
  apt-get install google-chrome-stable
  update-alternatives --set x-www-browser /usr/bin/google-chrome-stable
  update-alternatives --set gnome-www-browser /usr/bin/google-chrome-stable
fi


########################################################################
#### FILES #############################################################
########################################################################
read -p "$(echo -e "\n\e[1m\e[4mCopy some cool scripts (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  chmod +x "$current_dir"/bin/*
  cp "$current_dir"/bin/* /usr/bin/
  update-notification.sh -I      # Install update-notification
fi

read -p "$(echo -e "\n\e[1m\e[4mCopy some cool wallpapers (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  cp "$current_dir"/wallpapers/* /usr/share/images/bunsen/wallpapers
fi

read -p "$(echo -e "\n\e[1m\e[4mCopy some cool icon packs (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  unzip -FF "$current_dir"/files/icons.zip --out "$current_dir"/files/icons-full.zip
  unzip "$current_dir"/files/icons-full.zip -d /usr/share/icons/
fi

read -p "$(echo -e "\n\e[1m\e[4mCopy some cool fonts (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  unzip "$current_dir"/files/fonts.zip -d /usr/share/fonts/
fi

read -p "$(echo -e "\n\e[1m\e[4mCopy some cool themes (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  unzip "$current_dir"/files/themes.zip -d /usr/share/themes/
fi

########################################################################
#### SYSTEM CONFIG #####################################################
########################################################################
## DISABLE DISPLAY MANAGER
read -p "$(echo -e "\n\e[1m\e[4mDisable graphical display manager (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  systemctl set-default multi-user.target
fi

read -p "$(echo -e "\n\e[1m\e[4mEnable CTRL+ALT+BACKSPACE for kill X (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  echo 'XKBOPTIONS="terminate:ctrl_alt_bksp"' >> /etc/default/keyboard
fi

### SERVICES
read -p "$(echo -e "\n\e[1m\e[4mDisable some stupid services (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  systemctl disable NetworkManager-wait-online.service
  systemctl disable ModemManager.service
  systemctl disable pppd-dns.service
fi

# GRUB CONIFG
read -p "$(echo -e "\n\e[1m\e[4mSkip Grub menu (only one OS)  (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  for i in $(cat "$current_dir"/config/grub_skip.conf  | cut -f1 -d=);do
    sed -i "/\b$i=/Id" /etc/default/grub
  done
  cat "$current_dir"/config/grub_skip.conf >> /etc/default/grub
  update-grub
fi
read -p "$(echo -e "\n\e[1m\e[4mShow messages during boot  (Y/n)?\e[0m ")" q
if [ "${q,,}" != "n" ]; then
  for i in $(cat "$current_dir"/config/grub_text.conf  | cut -f1 -d=);do
    sed -i "/\b$i=/Id" /etc/default/grub
  done
  cat "$current_dir"/config/grub_text.conf >> /etc/default/grub
  update-grub
fi


########################################################################
#### USER CONFIG #######################################################
########################################################################
# tint2 config
read -p "$(echo -e "\n\e[1m\e[4mAdd tin2 themes (Y/n)?\e[0m ")" q
if [ "${q,,}" = "y" ]; then
  cp "$current_dir"/config/*.tint /usr/share/bunsen/skel/.config/tint2/
  ls -d /home/* | xargs -I {} cp "$current_dir"/config/*.tint {}.config/tint2/
fi

# aliases
read -p "$(echo -e "\n\e[1m\e[4mAdd some aliases (Y/n)?\e[0m ")" q
if [ "${q,,}" = "y" ]; then
   cat "$current_dir"/config/aliases >> /usr/share/bunsen/skel/.bash_aliases
  ls -d /home/* | xargs -I {} cp /usr/share/bunsen/skel/.bash_aliases {}/
fi


exit 
# Config shortcut in Openbox:
vi $HOME/.config/openbox/rc.xml
  <keyboard>
    ...
    <keybind key="C-Tab">
      <action name="Execute">
        <command>rofi -show drun</command>
      </action> 
    </keybind>
    <keybind key="A-Tab">
      <action name="Execute">
        <command>rofi -show window</command>
      </action> 
    </keybind>    
    ...

# OPENBOX AUTOSTART
vi $HOME/.config/openbox/autostart
brightness.sh -def &           # Set default brightness
xmodmap $HOME/.Xmodmap &
xbindkeys &
syndaemon -i 1 -d &           # Disable touchpad when using keyboard


