# nvim-config

- [nvim-config](#nvim-config)
  - [Pre Setup](#pre-setup)
  - [setup_windows.ps1](#setup_windows.ps1)
  - [Todo](#todo)

A nvim configuratin written in lua.

This sets up nvchad along with some intuitive remaps.

## Pre Setup

- refer to nvchad install docs to match all pre requisites

## setup_windows.ps1

This PowerShell script adds a symbolic link pointing to the current directory to Neovim's Windows default path. Before generating a new symbolic link, it asks the user to confirm deletion of any folders or symbolic links with the same name that currently exist at the link path.

## Todo

- cmake-tools
- c / c++ formatting and linting
- nvim-dap
- nvim-surround neovim
- code completion using ai
- persisted.nvim
