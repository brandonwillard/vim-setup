# Introduction

These are my personal, hacked-up Vim settings/plugins.

# Setup
Clone this repository into `~/.vim`, then create a symbolic link to the `vimrc` file in your home directory 
(or wherever Vim expects it), e.g.

```$ ln -s /home/username/.vim/vimrc .vimrc ```

Clone the most recent [Vundle](https://github.com/gmarik/Vundle.vim) in `~/.vim/bundle/`:

```$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim```

You'll have to open Vim and run `BundleInstall` to setup the plugins mentioned in `vimrc`.

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


