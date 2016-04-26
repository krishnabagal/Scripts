

#-------------------
# Personnal Aliases
#-------------------
export GREP_COLOR='0;35'
export GREP_OPTIONS='--color=auto'
alias cp='cp -apvri'
alias mv='mv -v'
alias df='df -Th'
alias h='history'
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias nc="nc -v -w 5"
alias pwd="pwd -P"
alias ssh="ssh -v"
alias ps="ps ax -o user,pid,%cpu,%mem,bsdtime,command"

PS1="|\[\e[32m\]\u:\[\e[36m\]\h:\[\e[35m\]\w:\[\e[31m\]\$?\[\e[0m\]:>> "

awkp()
{
    /bin/awk {'print $NF'}
}

whatmypubIP()
{
        /usr/bin/dig +short myip.opendns.com @resolver1.opendns.com
}

whatmypvtIP()
{
        /usr/bin/curl -s ifconfig.me/forwarded
}

function extract()
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via extract" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

genpas() {
        local l=$1
        [ "$l" == "" ] && l=16
        tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}
