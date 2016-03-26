# Vagrant
alias vagrant_www='cd ~/vagrant/www'
alias vagrant_up='cd ~/vagrant/www && vagrant up'
alias vagrant_halt='cd ~/vagrant/www && vagrant halt'

#Productivity
mcd() { mkdir -p "$1"; cd "$1";} 
alias apt-get='sudo apt-get'
alias reload='source ~/.bashrc'
alias ..='cd ..'
alias ...='cd ../..'

# some more ls aliases
alias la='ls -lA'
alias l='ls -l'

#Tools
alias genpasswd="strings /dev/urandom | grep -o '[[:alnum:]]' | head -n 30 | tr -d '\n'; echo" 

# System info
alias meminfo='free -h -l -t'
alias ps?="ps aux | grep" 

# Networking
alias port='netstat -tulanp'

# Extract files with different types
extract() {
    if [ -f $1 ]; then
        case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
            esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Copy to clipboard from file
cb() {
local _scs_col="\e[0;32m"; local _wrn_col='\e[1;31m'; local _trn_col='\e[0;33m'
    # Check that xclip is installed.
    if ! type xclip > /dev/null 2>&1; then
        echo -e "$_wrn_col""You must have the 'xclip' program installed.\e[0m"
    # Check user is not root (root doesn't have access to user xorg server)
    elif [[ "$USER" == "root" ]]; then
        echo -e "$_wrn_col""Must be regular user (not root) to copy a file to the clipboard.\e[0m"
    else
        # If no tty, data should be available on stdin
        if ! [[ "$( tty )" == /dev/* ]]; then
            input="$(< /dev/stdin)"
            # Else, fetch input from params
        else
            input="$*"
        fi
        if [ -z "$input" ]; then  # If no input, print usage message.
            echo "Copies a string to the clipboard."
            echo "Usage: cb <string>"
            echo "       echo <string> | cb"
        else
            # Copy input to clipboard
            echo -n "$input" | xclip -selection c
            # Truncate text for status
            if [ ${#input} -gt 80 ]; then input="$(echo $input | cut -c1-80)$_trn_col...\e[0m"; fi
                # Print status.
                echo -e "$_scs_col""Copied to clipboard:\e[0m $input"
            fi
    fi
}
function cbf() { cat "$1" | cb; }  
# Copy SSH public key
alias cbssh="cbf ~/.ssh/id_rsa.pub"  
# Copy current working directory
alias cbwd="pwd | cb"  
# Copy most recent command in bash history
alias cbhs="cat $HISTFILE | tail -n 1 | cb" 

#dockerize-commands
alias composer="docker run --rm -u $UID -v $PWD:/app composer/composer"
alias node="docker run -ti --rm -u $UID -v `pwd`:/data dragonmantank/nodejs-grunt-bower node"
alias grunt="docker run -ti --rm -u $UID -v `pwd`:/data dragonmantank/nodejs-grunt-bower grunt"
alias npm="docker run -ti --rm -u $UID -v `pwd`:/data dragonmantank/nodejs-grunt-bower npm"
alias bower="docker run -ti --rm -u $UID -v `pwd`:/data dragonmantank/nodejs-grunt-bower bower"
