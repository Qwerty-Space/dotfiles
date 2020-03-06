# dotfiles
---

### Directory tree example:
.
├── bash
│   ├── .bash_aliases
│   └── .bashrc
├── code
│   └── .config
│       └── Code - OSS
│           └── User
│               ├── keybindings.json
│               └── settings.json
└── compton
    └── .config
        └── compton
            └── compton.conf

### Commands:
|    Command    | Description                                                                                    |
|---------------|------------------------------------------------------------------------------------------------|
| `stow dir`    | Enable config, create symlink to the files in that directory in the correct directory in $HOME |
| `stow -D dir` | Disable config, remove the symlinks                                                            |


Yes this readme is just for reminding me how it works
