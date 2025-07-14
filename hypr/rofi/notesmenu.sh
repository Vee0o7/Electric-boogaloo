#!/usr/bin/env bash

notesdir="$HOME/Documents/notes"

# CMDs
newname=$(date +"%a_%dXX_%b_%Y_%^p" | sed -r "s/1XX/1st/p;s/2XX/1nd/p;s/3XX/1rd/p;s/([0-9])XX/\1th/;s/^(.)/\L\1/")
files=$(ls -1c "$notesdir")

run_rofi() {
	echo -e "New:\n$files" | rofi -dmenu -replace -match-only
}

edit_cmd() {
	ghostty --command="vim $1"
}

new_note() {
	name=$(echo -e "$files" | sed "s/.md$//" | rofi -dmenu -replace -format f ) || return 1 # -mesg "default name: $newname" # cant figure out how to style this nicely
	if [[ $name == "" ]]; then
	    edit_cmd "$notesdir/$newname.md"
        else
	    edit_cmd "$notesdir/$name.md"
        fi
}

# Actions
main() {
	chosen="$(run_rofi)" || exit
	case ${chosen} in
		"New:")
			new_note || main;;
		*)
			edit_cmd "$notesdir/$chosen";;
	esac
}

main
