# dotfiles

Some very basic dotfiles. I assume nvim
[nvim](https://github.com/neovim/neovim)

## tmux sessionizer

Tmux sessionizer

### Requirements

fzf and tmux

[fzf](https://github.com/junegunn/fzf)

```sh
mdkir -p ~/.local/bin
cp tmux/tmux.conf ~/.tmux.conf
cp tmux/tmux-sessionizer.bash ~/.local/bin/tmux-sessionizer.bash
chmod +x ~/.local/bin/tmux-sessionizer.bash 
tmux source-file ~/.tmux.conf
```
