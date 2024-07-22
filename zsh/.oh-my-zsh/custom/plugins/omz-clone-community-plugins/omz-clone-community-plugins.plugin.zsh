function _omz_clone_plugin() {
  local plugin_name="$1"
  local git_url="$2"
  if [ -d "$ZSH_CUSTOM/plugins" ] && ! [ -d "$ZSH_CUSTOM/plugins/$plugin_name" ]; then
    echo "${GREEN}Installing custom omz plugin:${NOCOLOR} $plugin_name"
    git clone --depth 1 "$git_url" "$ZSH_CUSTOM/plugins/$plugin_name"
    echo ""
  fi
}

function omz_clone_community_plugins() {
  _omz_clone_plugin "zsh-syntax-highlighting" "https://github.com/zsh-users/zsh-syntax-highlighting"
  _omz_clone_plugin "zsh-autosuggestions" "https://github.com/zsh-users/zsh-autosuggestions"
}
