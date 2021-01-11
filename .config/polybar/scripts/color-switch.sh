#!/bin/bash

## Author : Aditya Shakya
## Github : adi1090x

SDIR="$HOME/.config/polybar/scripts"

MENU="$(rofi -sep "|" -dmenu -i -p 'Select' -location 3 -columns 1 -xoffset -28 -yoffset 80 -width 12 -hide-scrollbar -line-padding 4 -padding 20 -lines 10 <<< "> amber|> blue|> blue-grey|> brown|> cyan|> deep-orange|> deep-purple|> green|> grey|> indigo|> lime|> orange|> pink|> purple|> red|> teal|> yellow |> gruvbox-light|> gruvbox-dark|> nord|> nightly|> solarized-dark |> tomorrow-night |>  tomorrow-night-bright")"
            case "$MENU" in
				## Colors
				*amber) $SDIR/colors.sh -amber ;;
				*blue) $SDIR/colors.sh -blue ;;
				*blue-grey) $SDIR/colors.sh -blue-grey ;;
				*brown) $SDIR/colors.sh -brown ;;
				*cyan) $SDIR/colors.sh -cyan ;;
				*deep-orange) $SDIR/colors.sh -deep-orange ;;
				*deep-purple) $SDIR/colors.sh -deep-purple ;;
				*green) $SDIR/colors.sh -green ;;
				*grey) $SDIR/colors.sh -grey ;;
				*indigo) $SDIR/colors.sh -indigo ;;
				*lime) $SDIR/colors.sh -lime ;;
				*orange) $SDIR/colors.sh -orange ;;
				*pink) $SDIR/colors.sh -pink ;;
				*purple) $SDIR/colors.sh -purple ;;
				*red) $SDIR/colors.sh -red ;;
				*teal) $SDIR/colors.sh -teal ;;
				*yellow) $SDIR/colors.sh -yellow ;;
				*gruvbox-light) $SDIR/colors.sh -gruvbox-light;;
				*gruvbox-dark) $SDIR/colors.sh -gruvbox-dark;;
				*nord) $SDIR/colors.sh -nord;;
				*nightly) $SDIR/colors.sh -nightly;;
				*solarized-dark) $SDIR/colors.sh -solarized-dark;;
				*tomorrow-night) $SDIR/colors.sh -tomorrow-night;;
				*tomorrow-night-bright) $SDIR/colors.sh -tomorrow-night-bright;;
            esac
