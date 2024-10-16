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

if [ $# -eq 0 -o $# -eq 1 -a "$1" = "-h" ]
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
	echo "-ihs	Input Hidden Search (<input type=\"hidden\" name=\"example\" value=\"example\">)"
	echo "-eda	Empty Data Attributes (<div id=\"user\" data-user-id=\"\" data-user-role=\"\">)"
	echo
	echo "+================================================+"

elif [ $# -eq 2 -a "$1" = "-ihs" -a "$2" = "-eda" -o $# -eq 2 -a "$1" = "-eda" -a "$2" = "-ihs" ]
then
	list=()	
	while IFS= read -r line
	do
		list+=("$line")
	done

	for url in "${list[@]}"
	do
		parameters=$(curl -Lsk "$url" | grep -Eo $'data\-[A-Za-z0-9_-]+=\'\'|data\-[A-Za-z0-9_-]+=""|<input[^>]*type=\'hidden\'[^>]*value=[^>]*>|<input[^>]*type="hidden"[^>]*value=[^>]*>' | tr -s ' ' '\n' | grep -Eo $'^data\-[A-Za-z0-9_-]+=\'\'|^data\-[A-Za-z0-9_-]+=""|^name=\'[^\']*\'|^name="[^"]*"' | sed -E s'/name=|data\-//' | tr -d $'\'"' | awk -F '=' '{print $1"=hiddenrecon"}' | sed s'/\[/%5B/g' | sed s'/\]/%5D/g' | sort -u | tr -s '\n' '&'  | sed s'/\&$//')	

		assembling_url
	done

elif [ $# -eq 1 -a "$1" = "-ihs" ]
then
	list=()
	while IFS= read -r line
	do
		list+=("$line")
	done

	for url in "${list[@]}"
	do
		parameters=$(curl -Lsk "$url" | grep -Eo $'<input[^>]*type=\'hidden\'[^>]*value=[^>]*>|<input[^>]*type="hidden"[^>]*value=[^>]*>' | tr -s ' ' '\n' | grep -Eo $'^name=\'[^\']*\'|name="[^"]*"' | cut -d '=' -f2 | tr -d $'\'"' | sed s'/$/=hiddenrecon/' | sed s'/\[/%5B/g' | sed s'/\]/%5D/g' | sort -u | tr -s '\n' '&' | sed s'/\&$//')

		assembling_url
	done

elif [ $# -eq 1 -a "$1" = "-eda" ]
then
	list=()
	while IFS= read -r line
	do
		list+=("$line")
	done

	for url in "${list[@]}"
	do
		parameters=$(curl -Lsk "$url" | grep -Eo $'data-[A-Za-z0-9_-]+=\'\'|data-[A-Za-z0-9_-]+=""' | sed s'/^data\-//' | awk -F '=' '{print $1"=hiddenrecon"}' | sort -u | tr -s '\n' '&' | sed s'/\&$//')

		assembling_url
	done

else
	$0
fi
