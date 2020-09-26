# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# START awesome prompt

# prompt will look like:
# [<exit_code> <time> <history #> <command #> <user>@<host> <path>
# <$(user)|#(root)> ...


get_time() {
	echo $(TZ=UTC date +%Y%m%dT%H%M%S%z)
}

get_exit() {
	if [[ $1 == '0' ]]
	then
		echo -e "\e[32m$1\e[0m\e[1m"
	else
		echo -e "\e[31m$1\e[0m\e[1m"
	fi
}


shopt -s histappend

make_prompt() {
	history -a
	history -c
	history -r
#	PS1='\[\e[1m\][$(get_exit $?) $(get_time) \! \# \u@\h \w]\n$ \[\e[0m\]'
	if [[ $VIRTUAL_ENV ]];
	then
		VENV="(${VIRTUAL_ENV}) "
	else
		VENV=""
	fi
	if [[ -f ~/.bash_privacy ]]
	then
		PS1='\[\e[1m\][$(get_exit $?) 19840413T133742+0000 \! \# user@localhost \w ]\n'${VENV}'$ \[\e[0m\]'
	else
		PS1='\[\e[1m\][$(get_exit $?) $(get_time) \! \# \u@\h \w ]\n'${VENV}'$ \[\e[0m\]'
	fi
	# set environment variable for global pwd
	echo "$(pwd)" > ~/.globalpwd
}

cd "$(cat ~/.globalpwd)"

PROMPT_COMMAND=make_prompt

# EOF awesome prompt

# term_title()

function term_title() {
	echo -ne "\033]0;${1}\007"
}

# EOF term_title()


# cheat.sh

howto() {
	lang="${1}"; shift
	echo curl "https://cheat.sh/"${lang}"/$*"
	curl "https://cheat.sh/"${lang}"/$*"
}

# EOF cheat.sh


