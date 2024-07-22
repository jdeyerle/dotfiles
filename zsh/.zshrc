# shell completion for brew 
# has to be set before oh-my-zsh is sourced
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="bira-minimal"

plugins=(
  # included
  colored-man-pages
  fancy-ctrl-z
  git
  ripgrep
  web-search

  # community
  zsh-syntax-highlighting 
  zsh-autosuggestions

  # custom
  bun
  gcloud
  kbg
  lazygit
  nvm
  omz-clone-community-plugins
)

source $ZSH/oh-my-zsh.sh
