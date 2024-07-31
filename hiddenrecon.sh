#!/bin/bash

function assembling_url () {

	if echo "$url" | grep -q '\?.*='
	then
		echo "$url&$parameters" | grep hiddenrecon
	elif echo "$url" | grep -Eq '\?[A-Za-z0-9_-]+$'
	then
		echo "$url=hiddenrecon&$parameters" | grep hiddenrecon
	elif echo "$url" | grep -q '\?$'
	then
		echo "$url$parameters" | grep hiddenrecon
	elif echo "$url" | grep -q "/$"
	then
		echo "$url?$parameters" | grep hiddenrecon
	else
		echo "$url/?$parameters" | grep hiddenrecon
	fi

}

if [ $# -eq 0 ] || echo "$1" | grep -Eiq "\-h"
then
echo "                          -> Your perfect recognition for HTMLi and XSS <-                           "
echo "	         _________ ______   ______   _______  _          _______  _______  _______  _______  _       "
echo "|\     /|\__   __/(  __  \ (  __  \ (  ____ \( (    /|  (  ____ )(  ____ \(  ____ \(  ___  )( (    /|"
echo "| )   ( |   ) (   | (  \  )| (  \  )| (    \/|  \  ( |  | (    )|| (    \/| (    \/| (   ) ||  \  ( |"
echo "| (___) |   | |   | |   ) || |   ) || (__    |   \ | |  | (____)|| (__    | |      | |   | ||   \ | |"
echo "|  ___  |   | |   | |   | || |   | ||  __)   | (\ \) |  |     __)|  __)   | |      | |   | || (\ \) |"
echo "| (   ) |   | |   | |   ) || |   ) || (      | | \   |  | (\ (   | (      | |      | |   | || | \   |"
echo "| )   ( |___) (___| (__/  )| (__/  )| (____/\| )  \  |  | ) \ \__| (____/\| (____/\| (___) || )  \  |"
echo "|/     \|\_______/(______/ (______/ (_______/|/    )_)  |/   \__/(_______/(_______/(_______)|/    )_)"
echo "[ by: foorw1nner | x.com/foorw1nner | hackerone.com/foorw1nner | github.com/foorw1nner ]"

	echo
	echo "[buffers] | hiddenrecon.sh"
	echo "+================================================+"
	echo
	echo "-h	Show This Help Message                  "
	echo "-eih	Empty Input Hidden (<input type=\"hidden\" name=\"exemple\" value=\"\">)"
	echo "-eda	Empty Data Attributes (<div id=\"user\" data-user-id=\"\" data-user-role=\"\">)"
	echo
	echo "+================================================+"

elif echo "$1" | grep -Eiq "\-eih|\-eda" && echo "$2" | grep -Eiq "\-eih|\-eda"
then
	while IFS= read -r line
	do
		lista+=("$line")
	done

	for url in "${lista[@]}"
	do
		parameters=$(curl -Lsk "$url" | grep -Eo $'<input[^>]*type=\'hidden\'[^>]*value=\'\'[^>]*>|<input[^>]*type="hidden"[^>]*value=""[^>]*>|<[A-Za-z0-9_-]+\s[^>]*data-[A-Za-z0-9_-]+=\'\'[^>]*>|<[A-Za-z0-9_-]+\s[^>]*data-[A-Za-z0-9_-]+=""[^>]*>' | tr -s ' ' '\n' | grep -E $'^data\-[A-Za-z0-9_-]+=\'\'|^data\-[A-Za-z0-9_-]+=""|^name=' | sed -E s'/name=|data\-//' | tr -d $'\'"' | awk -F '=' '{print $1"=hiddenrecon"}' | sort -u | tr -s '\n' '&'  | sed s'/\&$//')	
		
		assembling_url
	done

elif echo "$1" | grep -Eiq "\-eih|\-eda" && echo "$2" | grep -Eviq "\-eih|\-eda"
then
	if echo "$1" | grep -Eiq "\-eih"
	then
		while IFS= read -r line
		do
			lista+=("$line")
		done

		for url in "${lista[@]}"
		do
			parameters=$(curl -Lsk "$url" | grep -Eo $'<input[^>]*type=\'hidden\'[^>]*value=\'\'[^>]*>|<input[^>]*type="hidden"[^>]*value=""[^>]*>' | tr -s ' ' '\n' | grep '^name=' | cut -d '=' -f2 | tr -d $'\'"' | sort -u | sed s'/$/=hiddenrecon/' | tr -s '\n' '&' | sed s'/\&$//')
		
			assembling_url
		done

	else
		while IFS= read -r line
		do
			lista+=("$line")
		done

		for url in "${lista[@]}"
		do
			parameters=$(curl -Lsk "$url" | grep -Eo $'<[A-Za-z0-9_-]+\s[^>]*data-[A-Za-z0-9_-]+=\'\'[^>]*>|<[A-Za-z0-9_-]+\s[^>]*data-[A-Za-z0-9_-]+=""[^>]*>' | tr -s ' ' '\n' | grep "^data\-" | grep -E $'data-[A-Za-z0-9_-]+=\'\'|data-[A-Za-z0-9_-]+=""' | sed s'/^data-//' | cut -d '=' -f1 | sort -u | sed s'/$/=hiddenrecon/' | tr -s '\n' '&' | sed s'/\&$//')
		
			assembling_url	
		done

	fi
else
	$0
fi
