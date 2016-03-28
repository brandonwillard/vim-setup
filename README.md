# Introduction

These are my personal, hacked-up Vim settings/plugins.  They have a special emphasis
on generic [REPL](https://en.wikipedia.org/wiki/Read%E2%80%93eval%E2%80%93print_loop)
and [noweb](https://en.wikipedia.org/wiki/Noweb) environments, as well as integration of the two. 


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
features/support; the only noticeable migration requirement involves creating
symlinks to one's original Vim setup: 
```
$ ln -s ~/.vim ~/.config/nvim
$ ln -s ~/.vimrc ~/.config/nvim/init.vim
```

Oh, and if you're installing a plugin with scripts in "rplugin/*",
run `:UpdateRemotePlugins`; otherwise, the plugin scripts simply won't work.

Note: Neovim doesn't appear to have the old `+clientserver` functionality at the
moment ([see here](https://github.com/tpope/vim-dispatch/issues/163)), so
`--servername` isn't available and the Synctex features won't work.

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

To set up
[synctex](http://tex.stackexchange.com/questions/118489/what-exactly-is-synctex)
just create an alias for vim that sets the server name, e.g.
```
$ vim='vim --servername VIM' 
```
then, in an editor with synctex capabilities (`qpdfview` for this example), add a line
like the following for the "source editor" option:
```
vim --servername VIM --remote +%2 %1
```
(FYI: here, i.e. in qpdfview, `%1` is the filename and `%2` is the line number)


# Noweb
                          
There are two types of custom [noweb](https://en.wikipedia.org/wiki/Noweb)
settings that are worth mentioning, beyond simple noweb syntax highlighting
(currently via
[noweb.vim--McDermott](http://www.vim.org/scripts/script.php?script_id=3038))
and a simple addition for inline statements.  

First is the code (mostly Nvim-centric) for sending (Python) commands within a noweb file 
(I use the `.texw` extension for LaTeX + Python).  Those commands are currently found in
`after/ftplugin/noweb-tweaks.vim`.  

The other important feature attempts to preserve Vim options as one moves back-and-forth between
the LaTeX and Python parts of the document.  It relies on a neat plugin ([OnSyntaxChange](http://www.vim.org/scripts/script.php?script_id=4085)) that provides the
event hooks and a hackish routine that loads the LaTeX file settings, saves them, then does the same
for Python.  The saved settings are assigned to variables prefixed by the filetypes and loaded 
on invocation of the events.  It seems to work, so I can't complain.
If other Vim options need to be saved, there's an array that they can be added to, so look for that
in `after/ftplugin/texw.vim`.
Otherwise, this approach hasn't been generalized to any noweb pairing of
languages, but it looks quite possible to do with effectively the same code.

