# Introduction

These are my personal, hacked-up Vim settings/plugins.

# Setup

Clone this repository into `~/.vim`, then create a symbolic link to the `vimrc` file in your home directory 
(or wherever Vim expects it), e.g.

```
$ ln -s /home/username/.vim/vimrc .vimrc 
```

Clone the most recent [Vundle](https://github.com/gmarik/Vundle.vim) in `~/.vim/bundle/`:

```
$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
```

You'll have to open Vim and run `BundleInstall` to setup the plugins mentioned in `vimrc`.

## Neovim

I've recently added some [Neovim](https://github.com/neovim/neovim)
features/support; the only major difference
was the need for symlinks to the original vim setup:
```
$ ln -s ~/.vim ~/.config/nvim
$ ln -s ~/.vimrc ~/.config/nvim/init.vim
```

Oh, and if you're installing a plugin with scripts in "rplugin/*",
run `:UpdateRemotePlugins`; otherwise, the plugin scripts simply won't work.

# tmux

This setup contains a custom shell script, tmux settings and a Vim script that
enables fluid movement between Vim and tmux.  The "custom" part comes from the
desire to maintain the standard <kbd>Ctrl+w+h/j/k/l</kbd>
double/combination keystrokes to seemlessly move between panes/buffers/windows
in Vim and tmux.  I was having difficulties finding a good way to emulate double
key-sequence bindings in tmux and finally landed on the approach you see here.
The original inspiration is from [here](https://gist.github.com/hjdivad/d7f79b45ac2922336fec).

To set it up, create a link to `tmux.conf` (as `.tmux.conf`) in your home directory.
Otherwise, the `vimrc` file should include the necessary Vim plugin(s), and
the `.vim/` directory should contain the required shell scripts.

# LaTeX

To setup cool stuff like synctex just create an alias for vim that sets
the server name, e.g.
```
$ vim='vim --servername VIM' 
```
then, in an editor with synctex capabilities (qpdfview for this example), add a line
like the following for the "source editor" option:
```
vim --servername=VIM --remote +%2 %1
```
(FYI: here, i.e. qpdfview, `%1` is the filename and `%2` is the line number)

