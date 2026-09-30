## Set values
# Hide welcome message
set fish_greeting
set VIRTUAL_ENV_DISABLE_PROMPT "1"
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

## Environment setup
# Apply .profile: use this to put fish compatible .profile stuff in
if test -f ~/.fish_profile
  source ~/.fish_profile
end

# start tmux
if status is-interactive
and not set -q TMUX
    tmux -2 attach || tmux -2 new -s hack
end

# Set settings for https://github.com/franciscolourenco/done
set -U __done_min_cmd_duration 10000
set -U __done_notification_urgency_level low

# Set GOPATH
#set GOPATH ~/dev/go

# Set rust source path
# run the following: rustup component add rust-src
#set RUST_SRC_PATH (string join '/' (eval rustc --print sysroot) lib rustlib src rust src)

# set java home
#set JAVA_HOME /usr/lib/jvm/default/

# Ruby
#set RUBY_LOCAL_PATH_30 ~/.gem/ruby/3.0.0/bin

# Add ~/.local/bin to PATH
if test -d ~/.local/bin
    if not contains -- ~/.local/bin $PATH
        set -p PATH ~/.local/bin
    end
end

# Set PATH
set -p PATH ~/.tmux/plugins/tpm /usr/local/go/bin $GOPATH/bin ~/bin ~/.cargo/bin $RUBY_LOCAL_PATH_30 /bin /usr/sbin /sbin


## zoxide (autojump replacement)
zoxide init --cmd j fish | source

## Starship prompt
if status --is-interactive
   source ('/usr/bin/starship' init fish --print-full-init | psub)
end

## Functions
# Functions needed for !! and !$ https://github.com/oh-my-fish/plugin-bang-bang
function __history_previous_command
  switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end

function __history_previous_command_arguments
  switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end

if [ "$fish_key_bindings" = fish_vi_key_bindings ];
  bind -Minsert ! __history_previous_command
  bind -Minsert '$' __history_previous_command_arguments
else
  bind ! __history_previous_command
  bind '$' __history_previous_command_arguments
end

# Fish command history
function history
    builtin history --show-time='%F %T '
end

function backup --argument filename
    cp $filename $filename.bak
end

## Useful aliases
# Custom commands
alias virt_up='bash -c "$HOME/dev/virtualisation/virt_up.sh"'
alias virt_down='bash -c "$HOME/dev/virtualisation/virt_down.sh"'
alias anbox_up='bash -c "$HOME/dev/virtualisation/anbox_up.sh"'
alias anbox_down='bash -c "$HOME/dev/virtualisation/anbox_down.sh"'

# Replace ls with exa
alias ls='exa -al --color=always --group-directories-first --icons' # preferred listing
alias la='exa -a --color=always --group-directories-first --icons'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first --icons'  # long format
alias lt='exa -aT --color=always --group-directories-first --icons' # tree listing
alias l.='exa -a | egrep "^\."'                                     # show only dotfiles

# Replace some more things with better alternatives
alias cat='bat '
alias grep='rg --color=auto'
[ ! -x /usr/bin/yay ] && [ -x /usr/bin/paru ] && alias yay='paru --bottomup'

# Common use
alias rmpkg='sudo pacman -Rdd'
alias upd='sudo reflector --verbose -c DE -c IS -c SE --protocol https --sort rate --age 2 --latest 10 --save /etc/pacman.d/mirrorlist && sudo pacman -Syu && fish_update_completions && sudo updatedb'
alias ..='cd ..'
alias gitpkg='pacman -Q | grep -i "\-git" | wc -l'			    # List amount of -git packages

# Cleanup orphaned packages
alias cleanup='sudo pacman -Rns (pacman -Qtdq)'

# Get the error messages from journalctl
alias jctl='journalctl -p 3 -xb'

# Recent installed packages
alias rip='expac --timefmt="%Y-%m-%d %T" "%l\t%n %v" | sort | tail -200 | nl'
