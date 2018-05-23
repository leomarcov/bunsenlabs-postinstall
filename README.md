![seleccion_827](https://user-images.githubusercontent.com/32820131/40361602-3476698e-5dca-11e8-9aa4-2d91e4e734eb.png)

## BunsenLabs-Postinstall
**`bl-postinstall.sh`**: my personal postinstall script, themes and configs for BunsenLabs Helium.  
Althoughs is a collection of my particular useful themes, scripts and configs may be interesting for someone.  
The script exec many predefined actions:
```bash
./bl-postinstall.sh -h
Install configs and themes after BunsenLabs  installation
Usage: bl-postinstall.sh [-h] [-l] [-a <actions>] [-y] [-d]
   -l		Only list actions 
   -a <actions>	Only do selected actions (e.g: -a 5,6,10-15)
   -y		Auto-answer yes to all actions
   -d		Auto-answer default to all actions
   -h		Show this help

# List all actions:
$ ./bl-postinstall.sh -l
[1] Install Google Chrome, add to repositories and set has default browser
[2] Install some useful packages
[3] Install playonlinux and some dependencies
[4] Install rofi and config as default
[5] Install Sublimet Text, add repositories and set as default editor 
[6] Install VirtualBox 5.2, add to repositories and insert to Openbox menu
[7] Install VirtualBox Extension Pack
[8] Install script autosnap.sh (need Openbox config for autosnap with center clic in titlebar)
[9] Install script brightness.sh
[10] Install script ps_mem.py
[11] Install script update-notification.sh
[12] Config bl-exit window with the classic theme for all users
[13] Install default Conky theme for all users
[14] Install popular font pack
[15] Install Arc GTK theme and set as default for all users
[16] Install Numix-Paper icon theme and set as default for all users
[17] Install GoHome Openbox theme and set as default for all users
[18] Install Terminator themes for all users
[19] Install tint2 bar theme for all users
[20] Set Aptenodytes wallpaper as default for all users
[21] Config new bash prompt for all users
[22] Set default brightness when start Openbox
[23] Config useful aliases for all users (root inclusive)
[24] Disable some stupid services
[25] Enable CTRL+ALT+BACKSPACE for kill X server
[26] Config system for show messages during boot
[27] Config GRUB for skip menu
[28] Disable lightdm and config login in tty

# Exec all actions:
$ sudo ./bl-postinstall.sh -y

# Exec all actions and answer yes to all:
$ sudo ./bl-postinstall.sh -y

# Exec all actions and answer default to all:
$ sudo ./bl-postinstall.sh -d

# Exec only actions 5,7,10,11,12,13,14 and 15:
$ sudo ./bl-postinstall.sh -a 5,7,10-15
```

</br>

## Autosnap Windows for Openbox
[**`autosnap.sh`**](https://github.com/leomarcov/BunsenLabs-Postinstall/tree/master/autosnap-openbox): script for **autosnap windows** (half-maximice) in Openbox WM.  
The script snap the active windows an choose automatically the corner to snap according the mouse position: if the mouse is in the zone of corner left snap to this quadrant, if is in the center left snap to half left screen, if is in the center maximize the windows, etc.  
It should work in **1 or 2 monitors** (in horizontal).

![peek-12-10-2017-20-43](https://user-images.githubusercontent.com/32820131/40352231-9d64c1fa-5dae-11e8-8137-890cadf2c293.gif)

</br>

## Update Notification for tint 
[**`updagte-notification.sh`**](https://github.com/leomarcov/BunsenLabs-Postinstall/tree/master/update-notification-tint): script that checks periodically APT pending updates and show a notification in tint2 bar using executor plugin (since tint2 0.12.4).  

![seleccion_825](https://user-images.githubusercontent.com/32820131/40354912-55396e4c-5db5-11e8-9b22-aaeedc7e91e3.png)

</br>

## Numix-Paper icon theme
[**`numix-paper-icon-theme.zip`**](https://github.com/leomarcov/BunsenLabs-Postinstall/tree/master/numix-paper-icon-theme): icon theme based completely in symbolics links to Numix and Paper themes.  
The theme can be regenerated by **`numix-paper-icon-theme-sh`**, or modify the script to add others icons.

The theme contains:
  * Folder icons: grey icons from Numix (instead of yellow).
  * Panel icons: panel icons from Paper.
  * Apps icons: apps icons from Paper.
  * Rest come from Numix theme.
  
![numix-paper-icon-theme](https://user-images.githubusercontent.com/32820131/40285580-32b6e22c-5c9e-11e8-8567-01f56d1c12db.png)

</br>

## Brightness control
[**`brightness.sh`**](https://github.com/leomarcov/BunsenLabs-Postinstall/tree/master/brightness-control): script for increase/decrease and set default brightness using `xrandr`.  
```bash
$ ./brightness.sh -h
Inc/dec the brightness
Usage: brightness.sh -inc|-dec|-h|-I|-U
   -h	Show command help
   -def	Set default brightness (0.6)
   -inc	Increase the brightness
   -dec	Decrease the brightness
   -I	Install the script
   -U	Uninstall the script
```

