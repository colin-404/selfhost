
#!/usr/bin/env bash

set -e

update_and_basic_tools() {
  apt update
  apt install -y zsh vim
  chsh -s /bin/zsh
}

install_oh_my_zsh() {
  local zsh_dir="${ZSH:-$HOME/.oh-my-zsh}"
  if [ -d "$zsh_dir" ]; then
    echo "Oh My Zsh already present at $zsh_dir, skipping installer."
  else
    env ZSH="$zsh_dir" sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  fi

  if [ -f ./zshrc ]; then
    cp ./zshrc ~/.zshrc
  else
    echo "Warning: ./zshrc not found; skipping copy."
  fi

  local plugin_dir="$zsh_dir/custom/plugins/zsh-autosuggestions"
  if [ -d "$plugin_dir" ]; then
    echo "zsh-autosuggestions already present; skipping clone."
  else
    git clone https://github.com/zsh-users/zsh-autosuggestions.git "$plugin_dir"
  fi
}

configure_vim() {
  # Configure Vim
  cat << 'EOF' > ~/.vimrc
syntax on
set nu
EOF
}

install_go() {
  wget https://go.dev/dl/go1.25.4.linux-amd64.tar.gz
  rm -rf /usr/local/go && tar -C /usr/local -xzf go1.25.4.linux-amd64.tar.gz
  local export_line='export PATH=$PATH:/usr/local/go/bin'
  if ! grep -qxF "$export_line" ~/.zshrc; then
    printf '\n%s\n' "$export_line" >> ~/.zshrc
  fi
}

run_all() {
  update_and_basic_tools
  install_oh_my_zsh
  configure_vim
  install_go
}

case "$1" in
  zsh)
    update_and_basic_tools
    ;;
  ohmyzsh)
    install_oh_my_zsh
    ;;
  vim)
    configure_vim
    ;;
  go)
    install_go
    ;;
  all|"")
    run_all
    ;;
  *)
    echo "Usage: $0 {zsh|ohmyzsh|vim|go|all}"
    exit 1
    ;;
esac