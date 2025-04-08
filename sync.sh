#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
cd "$SCRIPT_DIR" || exit
true > switch.log
wm="gnome"
rebuild="false"

usage() {
	cat <<EOF

Usage: $0 [OPTION]...
Syncs home-manager with working flakes and commits to git

OPTIONS:
  --gnome                 Install gnome (Default option)
  --hypr                  Install hyprland
  -h, --help              Show help
  -r, --rebuild           Rebuild nixos
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
        -r | --rebuild)
                rebuild="true"
                shift
                ;;
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

command="home-manager switch --flake $flake_dir"
gencmd="home-manager generations"
gengrep="head -n 1"
if [[ "$rebuild" = "true" ]]; then
        command="sudo nixos-rebuild switch --flake $flake_dir"
        gencmd="nixos-rebuild list-generations"
        gengrep="grep current"
fi

gdiff=$(git diff -U0)
if [[ "$gdiff" != "" ]]; then
        echo "$gdiff" | $EDITOR
else
        echo "no changes to commit"
fi

script -qfa -c "$command"  -O >(ansifilter >> "$SCRIPT_DIR/switch.log")
gen=$($gencmd | $gengrep)
if [[ "$gen" != "$(git log -1 --pretty=%B)" ]]; then
        git commit -am "$gen"
fi
