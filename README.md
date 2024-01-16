# dotfiles

## Usage
These dotfiles are managed with [chezmoi](https://www.chezmoi.io/quick-start/#start-using-chezmoi-on-your-current-machine).

Step 1: Install chezmoi.
```
sh -c "$(curl -fsLS get.chezmoi.io)" -- -b $HOME/.local/bin
```

Step 2: Download and managed the dotfiles.
```
chezmoi init git@github.com:a45s67/dotfiles.git
```

Update
```
chezmoi update
chezmoi apply -v
```
