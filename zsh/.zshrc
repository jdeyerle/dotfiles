# brew shell completion
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

RED="\033[0;31m"
GREEN="\033[0;32m"
YELLOW="\033[1;32m"
BLUE="\033[0;34m"
NOCOLOR="\033[0m"

# Install custom omz plugins
omz_clone_plugin() {
  local plugin_name="$1"
  local git_url="$2"
  if [ -d "$ZSH_CUSTOM/plugins" ] && ! [ -d "$ZSH_CUSTOM/plugins/$plugin_name" ]; then
    echo "${GREEN}Installing custom omz plugin:${NOCOLOR} $plugin_name"
    git clone --depth 1 "$git_url" "$ZSH_CUSTOM/plugins/$plugin_name"
    echo ""
  fi
}

export omz_install_custom_plugins() {
  omz_clone_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"
  omz_clone_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
}

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira-minimal" # set by `omz`

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git web-search zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jdeyerle/.google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jdeyerle/.google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jdeyerle/.google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jdeyerle/.google-cloud-sdk/completion.zsh.inc'; fi

# Add personal scripts from dotfile repo to $PATH
# export PATH="$(realpath "$0" | sed 's|\(.*\)/.*|\1|')"/bin:"$PATH"
export PATH="$HOME/bin:$PATH"
# bun completions
[ -s "/Users/jdeyerle/.bun/_bun" ] && source "/Users/jdeyerle/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export CONFIG_DIR="$HOME/.config/lazygit"

alias js="jobs"

kbg() {
  local theme="$1"
  local kitty_dir="$HOME/.config/kitty"
  local bg_conf="$kitty_dir/current-background.conf"
  local wallpaper_dir="$kitty_dir/wallpapers/"

  if [ ! -d "$wallpaper_dir" ]; then
    echo "No wallpaper directory found at $wallpaper_dir"
    return 1
  fi

  local themes="$(ls $wallpaper_dir | grep -Eo '^[^\.]+')"

  if [ -z "$theme" ]; then
    echo "none"
    echo "$themes"
    return 0
  fi

  if [ "$theme" = "none" ]; then
    rm "$bg_conf"
  else
    local theme_file="$(ls $wallpaper_dir | grep $theme)"
    local theme_opts=$(basename "$theme_file" .png | awk 'BEGIN {FS="."};{print $2}')
    local linear_opt=$(echo "$theme_opts" | grep -Eo 'l')
    local tint_opt=$(echo "$theme_opts" | grep -Eo '\d{1,2}')

    echo "# file generated by kbg" > "$bg_conf"
    echo "# https://sw.kovidgoyal.net/kitty/conf/#color-scheme" >> "$bg_conf"
    echo "" >> "$bg_conf"
    echo "background #000000" >> "$bg_conf"
    echo "color0 #000000" >> "$bg_conf"
    echo "active_tab_foreground   #000000" >> "$bg_conf"
    echo "inactive_tab_background #000000" >> "$bg_conf"
    echo "" >> "$bg_conf"
    echo "background_image wallpapers/$theme_file" >> "$bg_conf"
    echo "background_image_layout cscaled" >> "$bg_conf"
    if [ -n "$linear_opt" ]; then
      echo "background_image_linear yes" >> "$bg_conf"
    fi
    if [ -n "$tint_opt" ]; then
      echo "background_tint 0.$tint_opt" >> "$bg_conf"
    fi
  fi

  kill -SIGUSR1 $(pgrep -a kitty)
}

_complete_kbg() {
  COMPREPLY="$(kbg)"
}

complete -F _complete_kbg kbg
