## Basics
- debian install with debian-de, xfce, ssh,
- add group sudo
- install build-essential, git, fzf, pkgconf, autotools, eza
- install spice-vdagent (clipboard sharing)

# SSH
## SSH setup
- `ssh-keygen -t ed25519 -C "moritz.huber@protonmail.com"`
- `eval "$(ssh-agent -s)"`
- `ssh-add ~/.ssh/id_ed25519`
- start ssh
- enable ssh

## Copy public ssh
- in the vm create `~/.ssh/authorized_keys`
- copy local .pub key into vm authorized_keys
- in /etc/ssh/sshd_config:
  - `PubkeyAuthentication yes` and `PasswordAuthentication no`

## connect with $TERM export
- create directory `mkdir -p ~/Repos/pg2` or clone repo
- (optional) `toe -ah` (show terminal types)
- `ssh -t moritz@192.168.64.6 "export TERM=xterm-256color; cd /home/moritz/Repos/pg2/; bash"`

## install neovim
- appimage -> chmod u+x -> into local/bin
- create .bash_aliases -> alias nvim=~/.local/bin/nvim-linux-arm64.appimage
- git clone nvim_config
- add `vim.g.clipboard = 'osc52'` to init.lua (clipboard over ssh)
- (optional) install tmux

## install sdl3
- clone repo
- make follow build documentation -> install prerequisites
- export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib

# unix commands
