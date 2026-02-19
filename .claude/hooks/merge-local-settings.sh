#!/usr/bin/env bash
set -euo pipefail
# settings.local.json の内容を settings.json にマージして削除するスクリプト
# SessionStart フックから呼び出される

LOCAL=".claude/settings.local.json"
SETTINGS=".claude/settings.json"

# settings.local.json が存在しない場合は何もしない
if [ ! -f "$LOCAL" ]; then
  exit 0
fi

# Node.js で JSON マージ処理
# 注意: permissions 以外のトップレベルキーはオブジェクト全体が上書きされる（deep マージではない）
#       env や attribution を部分的に追加したい場合は、permissions と同様に明示的なマージが必要
if ! node -e "
const fs = require('fs');

const localData = JSON.parse(fs.readFileSync('$LOCAL', 'utf8'));
const settingsData = JSON.parse(fs.readFileSync('$SETTINGS', 'utf8'));

// 配列をマージして重複を除去（元の順序を保持し、新規項目を末尾に追加）
function mergeUnique(a, b) {
  const base = Array.isArray(a) ? a : [];
  const additions = Array.isArray(b) ? b : [];
  const seen = new Set(base);
  for (const item of additions) {
    if (!seen.has(item)) {
      base.push(item);
      seen.add(item);
    }
  }
  return base;
}

// permissions をマージ
if (localData.permissions) {
  if (!settingsData.permissions) settingsData.permissions = {};
  const lp = localData.permissions;
  const sp = settingsData.permissions;
  if (lp.allow) sp.allow = mergeUnique(sp.allow, lp.allow);
  if (lp.deny)  sp.deny  = mergeUnique(sp.deny,  lp.deny);
  if (lp.ask)   sp.ask   = mergeUnique(sp.ask,   lp.ask);
  if (lp.defaultMode) sp.defaultMode = lp.defaultMode;
}

// permissions 以外のトップレベルキーをマージ（上書き）
for (const key of Object.keys(localData)) {
  if (key !== 'permissions') {
    settingsData[key] = localData[key];
  }
}

fs.writeFileSync('$SETTINGS', JSON.stringify(settingsData, null, 2) + '\n');
console.log('settings.local.json を settings.json にマージしました');
" ; then
  echo "マージに失敗しました。settings.local.json は削除しません" >&2
  exit 1
fi

# マージ成功後に削除
rm -f "$LOCAL"
echo "settings.local.json を削除しました"