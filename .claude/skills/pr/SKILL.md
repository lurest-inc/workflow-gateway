---
name: pr
description: コード変更をコミット・プッシュしてPRを作成する。実装完了後に `/pr` で呼び出す。変更ファイルを論理グループに分けてConventional Commits形式でコミットし、PRを自動作成する。
allowed-tools: Bash, Read, Glob
---

# PR作成スキル

実装完了後に変更をコミット・プッシュしてPRを作成するスキルです。

## 実行手順

### 1. 変更確認

```bash
git status
git diff --stat
```

変更ファイルを確認し、以下の観点で**論理的なグループ**に分類します：

- `feat:` 新機能の追加（マイナー版アップ）
- `fix:` バグ修正（パッチ版アップ）
- `refactor:` リファクタリング（バージョン影響なし）
- `test:` テストの追加・修正（バージョン影響なし）
- `docs:` ドキュメント更新（バージョン影響なし）
- `chore:` ビルド・ツール設定など（バージョン影響なし）
- `ci:` CI/CD設定変更（バージョン影響なし）

### 2. コミット（最大3コミット）

このプロジェクトは **release-please** を使用しているため、**Conventional Commits形式を厳守**してください。

```bash
# 論理グループごとにファイルをステージしてコミット
git add <対象ファイル>
git commit -m "feat: 機能説明 [#issue番号]"

# 例：複数グループがある場合
git add .github/workflows/
git commit -m "ci: ワークフローを更新 #123"

git add .claude/
git commit -m "chore: 設定ファイルを更新"
```

**コミットメッセージのルール:**
- 形式: `<type>[optional scope]: <description> [#issue-number]`
- 説明は日本語で記述
- Issue番号は関連する場合に記載
- **BREAKING CHANGE** はフッターに記載（メジャー版アップ）

### 3. プッシュ

```bash
git push origin HEAD
```

### 4. PR作成

```bash
# 現在のブランチ名とコミット内容からPRを作成
BRANCH=$(git branch --show-current)
ISSUE_NUM=$(echo "$BRANCH" | grep -oE '[0-9]+$' || echo "")

# コミット履歴からPR本文を生成
COMMITS=$(git log origin/main..HEAD --pretty=format:"- %s")

# PR作成
gh pr create \
  --title "$(git log -1 --pretty=format:'%s')" \
  --body "$(cat <<EOF
$([ -n "${ISSUE_NUM}" ] && echo "Closes #${ISSUE_NUM}" && echo "")
## 概要

$(git log origin/main..HEAD --pretty=format:"%b" -1 | head -5)

## 変更内容

${COMMITS}

## 動作確認

- [ ] ローカルで動作確認済み
- [ ] Biome チェック通過
- [ ] actionlint チェック通過

## 影響範囲

$(git diff --name-only origin/main..HEAD | head -5 | sed 's/^/- /')
EOF
)" \
  --base main
```

### 5. PR URL出力

```bash
gh pr view --json url --jq .url
```

## 重要なルール

### Conventional Commits 必須事項

| タイプ | 用途 | バージョン影響 |
|--------|------|--------------|
| `feat:` | 新機能追加 | マイナー版 |
| `fix:` | バグ修正 | パッチ版 |
| `refactor:` | リファクタリング | 影響なし |
| `test:` | テスト追加・修正 | 影響なし |
| `docs:` | ドキュメント更新 | 影響なし |
| `chore:` | ビルド・ツール設定 | 影響なし |
| `ci:` | CI/CD設定 | 影響なし |

### セキュリティチェック（コミット前）

機密情報がdiffに含まれていないか必ず確認：
- APIキー・シークレット
- 個人情報・顧客データ
- 社内限定の設計情報

### PRターゲットブランチ

- 通常の開発: `main` ブランチへ

## 使用タイミング

このスキルは以下の場面で使用します：

1. 実装が完了したとき
2. ユーザーが `/pr` を実行したとき
3. 「PRを作成して」と指示されたとき
4. 「コミットしてPRを出して」と指示されたとき

## 注意事項

- コミットは**最大3つまで**（論理的なグループ分けの範囲内）
- `git add -A` や `git add .` は**機密ファイルを誤って含めるリスク**があるため、ファイルを明示的に指定すること
- ブランチ名が `issues/#<番号>` 形式の場合、Issue番号を自動検出してコミットメッセージとPR本文に含める
