sudo apt-get install zsh vim tmux
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp gavin.zsh-theme ~/.oh-my-zsh/themes/
ln -s ~/work/dotfiles-linux/.[!.]* $HOME
rm -rf ~/.git
tmux -2 new
echo "Done"
