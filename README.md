# nvim-config

A nvim configuratin written in lua.

This sets up nvchad along with some intuitive remaps.

## setup_windows.ps1

This PowerShell script adds a symbolic link pointing to the current directory to Neovim's Windows default path. Before generating a new symbolic link, it asks the user to confirm deletion of any folders or symbolic links with the same name that currently exist at the link path.
