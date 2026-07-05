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

## Rime (Squirrel / Weasel)
新機器：`chezmoi apply` 後跑一次相依安裝腳本，再於輸入法選單執行「重新部署」。
```
# macOS
bash ~/Library/Rime/bootstrap-rime-deps.sh
# Windows（PowerShell）
powershell -ExecutionPolicy Bypass -File "$env:APPDATA\Rime\bootstrap-rime-deps.ps1"
```
更新 rime-ice / 洋蔥詞庫也是重跑同一支腳本（Rime 使用者目錄不是 git repo，個人設定全在 chezmoi 追蹤）。

跨 OS 結構：`private_Library/Rime/` 是共用設定的**正本**（macOS 直接 symlink）；`AppData/Roaming/Rime/` 只放 Windows 專屬檔（`weasel.custom.yaml` 等）和引用正本的 `*.tmpl` 包裝，Windows apply 時會展開成一般檔案。`.chezmoiignore` 依 OS 排除另一邊的目錄。
