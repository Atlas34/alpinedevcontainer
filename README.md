# Alpine 3.18 Dev Container

Alpine based Dev Container image for Visual Studio Code.

## Features

- Image based on **Alpine 3.18** (226MB)
- Contains the packages:
  - `libstdc++`: needed by the VS code server
  - `zsh`: main shell instead of `/bin/sh`
  - `git`: interact with Git repositories
  - `lazygit`: git TUI app
  - `htop`: process monitoring
  - `tmux`: terminal multiplexer
  - `ripgrep`: faster grep
  - `fzf`: Fuzzy finder
  - `fd`: faster find
  - `bat`: better cat app
  - `openssh-client`: use SSH keys
  - `vim`: edit files from the terminal
- Custom integrated terminal
  - Based on zsh and ZshPlug (https://github.com/Atlas34/zshPlug)
  - Uses the [Powerlevel10k](https://github.com/romkatv/powerlevel10k) theme
