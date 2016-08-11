#!/bin/bash

echo "BASHRC has run"

#Set term
export TERM=screen-256color


#Set color ls
alias ls='ls --color'
LS_COLORS='di=33;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=33;46:cd=33;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:'
export LS_COLORS

#Disable mesg
mesg n

#Set editor
export EDITOR=vim
export VISUAL=vim

#Set grep colors
export GREP_OPTIONS='--color=auto'

#Less colors
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'


# Change directory aliases
alias home='cd ~'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# Alias's for multiple directory listing commands
alias la='ls -Alh' # show hidden files
#alias ls='ls -Fh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only
alias lz='ls -lrt --block-size=MB'


# Search command line history
alias h="history | grep "

# Search files in the current folder
alias f="find . | grep "



# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'

# Alias for compile
alias vclean="rm -rf 00* *.o *.a *.tsk *.x *.x.* *.mk.[0-9]*"


# alias to show the date
alias da='date "+%Y-%m-%d %A %T %Z"'



# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'


# Extracts any archive(s) (if unp isn't installed)
extract () {
	for archive in $*; do
		if [ -f $archive ] ; then
			case $archive in
				*.tar.bz2)   tar xvjf $archive    ;;
				*.tar.gz)    tar xvzf $archive    ;;
				*.bz2)       bunzip2 $archive     ;;
				*.rar)       rar x $archive       ;;
				*.gz)        gunzip $archive      ;;
				*.tar)       tar xvf $archive     ;;
				*.tbz2)      tar xvjf $archive    ;;
				*.tgz)       tar xvzf $archive    ;;
				*.zip)       unzip $archive       ;;
				*.Z)         uncompress $archive  ;;
				*.7z)        7z x $archive        ;;
				*)           echo "don't know how to extract '$archive'..." ;;
			esac
		else
			echo "'$archive' is not a valid file!"
		fi
	done
}

# Copy file with a progress bar
cpp()
{
	set -e
	strace -q -ewrite cp -- "${1}" "${2}" 2>&1 \
	| awk '{
	count += $NF
	if (count % 10 == 0) {
		percent = count / total_size * 100
		printf "%3d%% [", percent
		for (i=0;i<=percent;i++)
			printf "="
			printf ">"
			for (i=percent;i<100;i++)
				printf " "
				printf "]\r"
			}
		}
	END { print "" }' total_size=$(stat -c '%s' "${1}") count=0
}

#TMUX CONFIG
tmux source-file ~/.tmux.conf

#ALIAS
alias ls="ls -p --color"
[ -f ~/.bbalias ] && . ~/.bbalias
alias veclipse="python /home/pshepher/bin/eclipse_wizard.py"
alias disk="du -S | sort -n -r | more"  #copied from Anthony
alias mbig="cd ~/workspace/mbig/"
alias doge="~/../mevangelis11/bin/doge"
alias rmlock="rm ~/workspace/eclipse_kepler/.metadata/.lock"
alias vtblog="cd /ae/data/tbflogs"
alias vcs="cd ~/workspace/mbig/checkout/"
alias trash="move_to_trash"
alias dumptrash="rm -rf /home/bzhang167/workspace/mbig/Trash/*"
alias vfix="fcat"
#EXPORT
export PATH=$PATH:~/vic/bin
export PATH=$PATH:~/bin
export HISTCONTROL=ignorespace

#AGUSTIN
if [[ `uname` = "AIX" ]]; then
    TABTITLE='IBM'
else
    if [[ `uname` = "Linux" ]]; then
        TABTITLE='Linux'
    else
        TABTITLE='Sun'
    fi
fi
echo -ne "\e]62:${TABTITLE}\a"

function getHostNameColor()
{
    if [ $(whoami) = "rdtrain" ]
    then
        echo -e "${RdTrain_color}[rdtrain]${Color_Off}"
    fi

    if [ $HOSTNAME = "tdonlydtrnvm01" -o $HOSTNAME =
        "tdolnjdtrnvm01" ]
    then
        echo -e ${TrdDev_Color}
    else
        case $OSTYPE in
            Linux)
                echo -e ${Linux_Color}
                ;;
            SunOS)
                echo -e ${Solaris_Color}
                ;;
            AIX)
                echo -e ${IBM_Color}
                ;;
            *)
                echo -e ${Color_Off}
                ;;
        esac
    fi
}



move_to_trash() {
    mv "$@" /home/bzhang167/workspace/mbig/Trash

}
