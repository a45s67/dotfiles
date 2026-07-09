# 安裝/更新 Rime 相依（rime-ice 全套 + 洋蔥純注音詞庫）— Windows / Weasel 版
# 需求：git 在 PATH。用法：powershell -ExecutionPolicy Bypass -File bootstrap-rime-deps.ps1
# 跑完後在小狼毫選單執行「重新部署」。macOS 用 bootstrap-rime-deps.sh。
#
# 注意：
# - Weasel 發行版已內建 bopomofo/stroke/luna_pinyin/cangjie5/essay/prelude；
#   若部署仍報缺，用 Git Bash 補跑 plum 的 `bash rime-install cangjie stroke bopomofo`。
# - 別裝 plum 的 double-pinyin 套件：會用 luna_pinyin 版 flypy 覆蓋 rime-ice 版 schema。
$ErrorActionPreference = "Stop"

$RimeDir = Join-Path $env:APPDATA "Rime"
$Tmp = Join-Path ([IO.Path]::GetTempPath()) ("rime-deps-" + [IO.Path]::GetRandomFileName())
New-Item -ItemType Directory -Path $Tmp | Out-Null

try {
    # 1) rime-ice 全套（檔案清單對齊上游 others/recipes/full.recipe.yaml）
    git clone --depth 1 https://github.com/iDvel/rime-ice (Join-Path $Tmp "rime-ice")
    $src = Join-Path $Tmp "rime-ice"
    foreach ($d in @("cn_dicts", "en_dicts", "opencc", "lua")) {
        $dst = Join-Path $RimeDir $d
        New-Item -ItemType Directory -Force -Path $dst | Out-Null
        Copy-Item -Recurse -Force (Join-Path $src "$d\*") $dst
    }
    foreach ($f in @(
        "default.yaml", "squirrel.yaml", "weasel.yaml",
        "rime_ice.schema.yaml", "rime_ice.dict.yaml", "t9.schema.yaml",
        "double_pinyin.schema.yaml", "double_pinyin_abc.schema.yaml",
        "double_pinyin_mspy.schema.yaml", "double_pinyin_sogou.schema.yaml",
        "double_pinyin_flypy.schema.yaml", "double_pinyin_ziguang.schema.yaml",
        "double_pinyin_jiajia.schema.yaml",
        "symbols_v.yaml", "symbols_caps_v.yaml",
        "radical_pinyin.schema.yaml", "radical_pinyin.dict.yaml",
        "melt_eng.schema.yaml", "melt_eng.dict.yaml", "custom_phrase.txt"
    )) { Copy-Item -Force (Join-Path $src $f) $RimeDir }

    # 2) 洋蔥純注音詞庫（上游無 plum recipe，檔案在 rimefiles/ 子目錄）
    git clone --depth 1 https://github.com/oniondelta/Onion_Rime_Files (Join-Path $Tmp "onion")
    foreach ($f in @(
        "bopomo_onion.extended.dict.yaml",
        "terra_pinyin_onion.dict.yaml",
        "terra_pinyin_onion_add.dict.yaml",
        "mixin_bpmf.dict.yaml",
        "essay-zh-hant-mc.txt"
    )) { Copy-Item -Force (Join-Path $Tmp "onion\rimefiles\$f") $RimeDir }
}
finally {
    Remove-Item -Recurse -Force $Tmp -ErrorAction SilentlyContinue
}

Write-Host "完成。請在小狼毫選單執行「重新部署」。"
