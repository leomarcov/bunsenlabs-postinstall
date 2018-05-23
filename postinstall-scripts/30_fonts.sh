#!/bin/bash
# ACTION: Install pack of fonts
# DESC: Pack of common fonts: Droid Sans, Open Sans, Roboto, Microsoft fonts, Oswald, Overpass, Profont, and others.
# DEFAULT: y

base_dir="$(dirname "$(dirname "$(readlink -f "$0")")")"

[ ! -d /usr/share/fonts/extra ] && mkdir /usr/share/fonts/extra/
unzip -o "$base_dir"/postinstall-files/fonts.zip -d /usr/share/fonts/extra/
