# .bashrc : do not echo any thing
#echo "=== Load ~/.bashrc ==="

export DOCKER_ID_USER=$(whoami)
export PLATFORM=$(uname -s)
export SHELL=/bin/bash
export TERM=xterm-256color
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=zh_TW.UTF-8
PATH=$PATH:$HOME/bin:/usr/local/bin:/sbin:/usr/local/sbin:/usr/sbin:/usr/local/go/bin:/usr/local/gradle/bin
export PATH

export NODE_PATH=/usr/local/lib/node_modules:/usr/lib/node_modules
if [ -f ~/.custEnv ]; then
   . ~/.custEnv
fi
# Get the aliases and functions
if [ -f ~/.bash_host ]; then
    . ~/.bash_host
fi

if [ "x$host" == "x" ];then
    host=`uname -n`
fi

if [ -f ~/.bash_common ]; then
    . ~/.bash_common
fi

if [ "$PLATFORM" == "Darwin" ]; then
    if [ -f ~/.alias_mac ]; then
        . ~/.alias_mac
    fi
else
    if [ -f ~/.alias ]; then
        . ~/.alias
    fi
fi


SSH_ENV="$HOME/.ssh/environment"
function start_agent {
     echo "Initialising new SSH agent..."
     /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
     echo succeeded
     chmod 600 "${SSH_ENV}"
     . "${SSH_ENV}" > /dev/null
     ls ~/.ssh/ | grep 'rsa\|dsa' | grep -v pub | awk '{printf "/usr/bin/ssh-add ~/.ssh/%s\n",$1}' | sh
}

getMySSHAgent


# disable control-s and control-q
stty -ixon


# ------------
# source bash-it
# ------------
# Path to the bash it configuration
export BASH_IT="/home/puritys/.bash_it"

# Lock and Load a custom theme file
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# Your place for hosting Git repos. I use this for private repos.
#export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=false

# Load Bash It
if [ -f "$BASH_IT/bash_it.sh" ] && [ -z "$HAS_LOAD_BASH_IT" ]; then
    source "$BASH_IT"/bash_it.sh
    export HAS_LOAD_BASH_IT=true
fi


#changePS
setTerm
PROMPT_COMMAND=changePS


# tw: dir +t,o+w
# ow: o+w
# st: Directory with the sticky bit set (+t) and not other-writable
# ex: executable
dirColor="38;2;0;119;193"
fileGreen="38;2;6;115;87"
fileRed="38;2;169;56;56"
fileGrey="38;2;84;97;105"
fileOrange="38;2;148;86;5"
filePurple="38;2;124;18;175"
LS_COLORS="no=00:fi=00:di=$dirColor:ow=$dirColor:tw=$dirColor:st=$dirColor:ln=36:pi=33:so=35:do=35:bd=33:cd=33:or=0:ex=0:*.tgz=$fileRed:*.zip=$fileRed:*.gz=$fileRed:*.bz2=$fileRed:*.bz=$fileRed:*error=$fileGrey:*.log=$fileGrey:*.jpg=$fileOrange:*.gif=$fileOrange:*.bmp=$fileOrange:*.png=$fileOrange:*.jpeg=$fileOrange:*.tif=$fileOrange:*.h=$fileGrey:*.c=$filePurple:*.cc=$filePurple:*.cpp=$filePurple:*.php=$filePurple:*.inc=$filePurple:*.js=$filePurple:*.ts=$filePurple:*.css=$filePurple:*.java=$filePurple:*.py=$filePurple:*.pl=$filePurple:*.sh=$filePurple:*.json=$fileGreen:*.yaml=$fileGreen:*.yml=$fileGreen:*.xml=$fileGreen:*.sql=$fileGreen"
LS_OPTIONS="-b --color=auto"
export LS_COLORS
export LS_OPTIONS
GREP_COLORS='mt=38;5;166:ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'
export GREP_COLORS

export FZF_DEFAULT_OPTS='
  --color light,hl:124,fg+:242,bg+:230,hl+:33
  --color info:52,prompt:245,spinner:245,pointer:245,marker:208
'
export _FASD_DATA=/tmp/.fasd
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
[ -d ~/.sh_tool/clvv-fasd-4822024/ ] && eval "$(fasd --init auto)"

# ---------
# Load Customized settings
# ---------
if [ -f ~/.ssh/config_customized ]; then
    alias ssh='ssh -F <(cat .ssh/config ~/.ssh/config_customized)'
fi

if [ -f ~/.bash_customized ]; then
    . ~/.bash_customized
fi

if [ -f ~/.alias_customized ]; then
    . ~/.alias_customized
fi


