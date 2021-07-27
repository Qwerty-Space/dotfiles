# dotfiles

### Directory tree example:
```
~/.dotfiles
├── home
│   └── code
│   │   └── .config
│   │       └── Code - OSS
│   │          └── User
│   │               ├── keybindings.json
│   │               └── settings.json
│   ├── firefox
│   │   └── .mozilla
│   │       ├── installs.ini
│   │       └── profiles.ini
│   ├── paru
│   │   └── .config
│   └── zsh
│       ├── dot-zprofile
│       └── dot-zshrc
└── root
    └── etc
        └── pacman.conf
```

### Commands:
|    Command                        | Description                                                                                    |
|-----------------------------------|------------------------------------------------------------------------------------------------|
| `stow --dotfiles -t $HOME dir`    | Enable config, create symlink to the files in that directory in the correct directory in $HOME |
| `stow -D dir`                     | Disable config, remove the symlinks                                                            |


Yes this readme is just for reminding me how it works
