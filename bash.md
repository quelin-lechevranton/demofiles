# Bash: demofile

| shells | | |
| ----------- | ----------- | ----------- |
| sh | The original Bourne shell | Present on every unix system |
| ksh | Original Korn shell | Richer shell programming environment than sh |
| csh | Original C-shell | C-like syntax; early versions buggy |
| tcsh | Enhanced C-shell | User-friendly and less buggy csh implementation |
| bash | GNU Bourne-again shell | Enhanced and free sh implementation |
| zsh | Z shell | Enhanced, user-friendly ksh-like shell |
| fish | ??? | |

```bash
--------- TERMINAL MOUVEMENT ----------
#mouvement macros inspired by emacs
ctrl+a #goes to beginning of the line
ctrl+e #goes to end of the line
ctrl+r #search past command
ctrl+shift+{x,c,v} #cut, copy, pastr
ctrl+u #clear line
ctrl+w #delete word
ctrl+c #cancel

ctrl+shift+u #type unicode character

--------- VARIABLES -------
? #stores the status code of last terminated program (0 for succes, i>=1 for error)
SHELL
PROMPT_DIRTRIM
CPLUS_INCLUDE_PATH
USER
HOSTNAME

--------- BASHRC ---------- 
#for colors cf. ANSI escape: eg. \e[1;31;24mA\e[0m
#use Caskaydia (from Nerd fonts) for special characters

${PWD##*/} #to remove whole path
${PWD%%/*} #to keep only root directory
${PWD#*/} #to remove root directory (and keep the rest of the path)
${PWD%/*} #to remove the file (and keep the whole path)


alias {gstat,gs}='git status'
# . is an alias for source
# source file.sh excute with current session / bash file.sh execute in a new session


--------- TERMINAL COMMANDS ----------
... | grep <keyword> #print only the lines where the keyword appears
... | less #navigate through stdout with space/b/q 
... | tail #last 10 lines
find -name "full_name_of_file.extension"

????????????????????????????????
df -h
du -h -d 1 .
ln -s
less / more ?
export #add something to the tail of the variable? export PATH=something ???
$ sh vs. $ source

ls -Rlh <folder>
history

--------- DNF ---------
dnf list --installed | grep <package_name>
rename abc ABC * #replace abc by ABC in all file names in the current directory
sudo dnf whatprovides <C_header_name>

--------- SCRIPTS ---------
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
```
