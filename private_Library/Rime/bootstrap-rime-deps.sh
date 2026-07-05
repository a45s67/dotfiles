#!/usr/bin/env bash
# 安裝/更新 Rime 相依（rime-ice 全套 + 洋蔥純注音詞庫）— macOS / Squirrel 版
# 新機器流程：chezmoi apply → 跑本腳本 → 鼠鬚管選單「重新部署」。
# 更新 rime-ice 也是重跑本腳本（~/Library/Rime 不是 git repo，別用 git pull）。
# Windows 用 bootstrap-rime-deps.ps1。
#
# 注意：
# - Squirrel SharedSupport 已內建 bopomofo/stroke/luna_pinyin/cangjie5/essay/prelude，不必安裝。
# - 別跑 `rime-install double-pinyin`：會用 luna_pinyin 版 flypy 覆蓋 rime-ice 版 schema。
set -euo pipefail

rime_dir="$HOME/Library/Rime"

# 1) rime-ice 全套：flypy（rime-ice 版）+ rime_ice 詞庫 + melt_eng + radical_pinyin + lua + opencc
if [ ! -d "$HOME/.local/share/plum" ]; then
  git clone --depth 1 https://github.com/rime/plum "$HOME/.local/share/plum"
fi
(cd "$HOME/.local/share/plum" && rime_dir="$rime_dir" bash rime-install iDvel/rime-ice:others/recipes/full)

# 2) 洋蔥純注音詞庫：上游無 plum recipe 且檔案在子目錄，clone 後只複製詞庫檔。
#    不碰 schema/symbols —— 那些是 chezmoi 追蹤的 symlink，覆蓋會寫穿到 repo。
onion_tmp="$(mktemp -d)"
git clone --depth 1 https://github.com/oniondelta/Onion_Rime_Files "$onion_tmp"
for f in \
  bopomo_onion.extended.dict.yaml \
  terra_pinyin_onion.dict.yaml \
  terra_pinyin_onion_add.dict.yaml \
  mixin_bpmf.dict.yaml \
  essay-zh-hant-mc.txt \
; do
  cp "$onion_tmp/rimefiles/$f" "$rime_dir/$f"
done
rm -rf "$onion_tmp"

echo "完成。請在鼠鬚管選單執行「重新部署」。"
