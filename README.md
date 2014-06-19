# Introduction

These are my personal hacked-up VIM settings/plugins.

# Setup
Create a symbolic link to the ```vimrc``` file in your home directory (or wherever VIM expects it):

```$ ln -s .vim/vimrc .vimrc ```

Clone the most recent [Vundle](https://github.com/gmarik/Vundle.vim) in ```./bundle/```:

```$ git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim```

You'll have to open VIM and run ```BundleInstall``` to setup the plugins mentioned in ```vimrc```.

# tmux

If you want VIM and tmux to work together (wrt. window movements) create a link
to ```tmux.conf```.  Otherwise, the ```vimrc``` file should include the necessary
VIM plugin(s).

The tmux idea/code is from [here](https://gist.github.com/hjdivad/d7f79b45ac2922336fec).

