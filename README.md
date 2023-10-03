# neovim-setup

Dirty, hacked-up Neovim setup using [vim-plug](https://github.com/junegunn/vim-plug) as the plugin manager.

Needs [a Nerd font](https://github.com/ryanoasis/nerd-fonts/releases/latest) to display correctly.

Currently only uses the rust-analyzer language server.

# Installation

This installation instructions is very incomplete, as it lacks support for (probably) a lot of system configs and other OSes.

## Prerequisites

As said, install [vim-plug](https://github.com/junegunn/vim-plug#installation) and [a Nerd font](https://github.com/ryanoasis/nerd-fonts/releases/tag/v3.0.2) first.

You can also install rust-analyzer.

## Check for directories

<!-- TODO: Explain this better -->

Check for directories. In init.lua it's mentioned that the plugin location is at `~/.vimplugins`. You can directly modify the plugin location variable and use the desired directory instead.

## Link

<!-- TODO: Investigate and find out how XDG works -->

_If you cloned this repository to your neovim config, you can skip this step._

Back up your previous plugin location and neovim config by either hardlinking them (see `ln (1)`) or moving/copying them over when backing up to a different partition.

Symlink the neovim config (usually on `~/.config/nvim`) with the directory where you cloned this project:

```sh
ln -s .../neovim-setup ~/.config/nvim
```

Note that you need the neovim config (usually on the home partition) 

## Install plugins

Open neovim (`nvim`). Usually you will see a lot of errors due to missing dependencies.

This is okay. Just do:

```vim
:PlugInstall
```

and restart neovim. You're done!


# NOTICE

## Folds

This project heavily uses `marker` folds, so it's much more bearable to see in an already-existing Vim/Neovim instance (not requiring this project to be installed).

See `usr_28.txt` for an introduction to folding.

# TODO

- Cleanup
- Add more support
- Clean & complete installation instructions
