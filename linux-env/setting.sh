apt install zsh
chsh -s /bin/zsh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ./zshrc ~/.zshrc


git clone https://github.com/zsh-users/zsh-autosuggestions.git ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions

# Configure Vim
cat << 'EOF' > ~/.vimrc
syntax on
set nu
EOF

