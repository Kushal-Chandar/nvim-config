# nvim-config

<!--toc:start-->

- [nvim-config](#nvim-config)
  - [Pre Setup](#pre-setup)
  - [Setup Windows Script](#setup-windows-script)
  - [Todo](#todo)
  <!--toc:end-->

A nvim configuration written in lua.

This sets up nvchad along with some intuitive remaps.

## Pre Setup

- refer to nvchad install docs to match all pre requisites

## Setup Windows Script

This PowerShell script adds a symbolic link pointing to the current directory
to Neovim's Windows default path. Before generating a new symbolic link, it
asks the user to confirm deletion of any folders or symbolic links with the
same name that currently exist at the link path.

## Linux Setup


```bash
cd ~/.config && git clone https://github.com/Kushal-Chandar/nvim-config.git nvim
```

## Todo

- cmake-tools
- c / c++ formatting and linting
- nvim-dap
- nvim-surround neovim
- code completion using ai 🤞
- persisted.nvim
