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

## Rime (Squirrel)
新機器：`chezmoi apply` 後跑一次相依安裝腳本，再於鼠鬚管選單執行「重新部署」。
```
bash ~/Library/Rime/bootstrap-rime-deps.sh
```
更新 rime-ice / 洋蔥詞庫也是重跑同一支腳本（`~/Library/Rime` 不是 git repo，個人設定全在 chezmoi 追蹤的 `*.custom.yaml` 與 `bopomo_onion.*`）。
