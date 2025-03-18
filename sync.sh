#! /usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

wm="gnome"
pull="false"
<<<<<<< HEAD
rebuild="false"
=======
>>>>>>> 19a04dd2178172db138049ee0e72426ff01b540a

usage() {
	cat <<EOF

Syncs home-manager with working flakes
Usage: $0 [OPTION]...

OPTIONS:
  -p, --pull              Pull from github (Default: false)
  --gnome                 install gnome (Default option)
  --hypr                  install hyprland
  -h, --help              Show help
  -r, --rebuild           rebuild
EOF
}

while [[ $# -gt 0 ]]; do
        case "${1}" in
        --hypr)
                wm="hypr"
                shift
                ;;
        --gnome)
                wm="gnome"
                shift
                ;;
        -p | --pull)
                pull="true"
                shift
                ;;
<<<<<<< HEAD
        -r | --rebuild)
                rebuild="true"
                shift
                ;;
=======
>>>>>>> 19a04dd2178172db138049ee0e72426ff01b540a
        -h | --help)
                usage
                exit 0
                ;;
        *) 
                echo "ERROR: Unrecognized option '$1'."
                echo "Try '$0 --help' for more infomation."
                exit 1
                ;;
        esac
done


flake_dir="$SCRIPT_DIR/gnome"
case "$wm" in
        gnome)
                flake_dir="$SCRIPT_DIR/gnome"
                ;;
        hypr)
                ;;
esac

if [[ "$pull" = "true" ]]; then
<<<<<<< HEAD
        echo && git pull
fi

if [[ "$rebuild" = "true" ]]; then
        echo && sudo nixos-rebuild switch --flake $flake_dir
fi

echo && home-manager switch --flake $flake_dir
=======
        git pull
fi

if [[ "$rebuild" = "true" ]]; then
        sudo nixos-rebuild switch --flake $flake_dir
fi

home-manager switch --flake $flake_dir
>>>>>>> 19a04dd2178172db138049ee0e72426ff01b540a

echo
echo Done.
