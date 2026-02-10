# Dispatch Test

## 概要

`dispatch-test.yml` は、`lurest-inc/private-workflows` 内のテスト用ワークフローを `workflow_dispatch` で手動起動するゲートウェイです。
GitHub Actions の UI または API から手動で実行します。

## トリガー

`workflow_dispatch`（手動実行）

## Inputs

| 名前 | 必須 | デフォルト値 | 説明 |
|------|:----:|------------|------|
| `target` | - | `test-a` | 起動するワークフロー（`test-a` / `test-b`） |
| `message` | - | `Dispatched via workflow-gateway` | `private-workflows` 側へ渡すメッセージ |
| `LUREST_DISPATCH_TOKEN` | ✅ | - | `private-workflows` に対して `Actions: write` 権限を持つ fine-grained PAT |

> **注意**: `LUREST_DISPATCH_TOKEN` は `workflow_dispatch` の input として渡します（Secret ではありません）。

## ジョブ構成

| ジョブ名 | 説明 |
|---------|------|
| `dispatch` | 入力値を検証し、`private-workflows` の対象ワークフローを `gh workflow run` で起動する |

### ステップ詳細

1. **App Token 取得** - GitHub App トークンを生成（`actions/create-github-app-token`）
2. **Validate inputs** - `target` が許可リストに含まれるか検証
3. **Resolve workflow file** - `target` に対応するワークフローファイル名を解決
4. **Dispatch private workflow** - `gh workflow run` で対象ワークフローを起動
5. **Summary** - 実行結果をジョブサマリーに出力

## 使用方法

GitHub Actions の UI から手動実行:

1. リポジトリの **Actions** タブを開く
2. **Lurest Gateway Dispatch (to private-workflows)** を選択
3. **Run workflow** をクリックして各入力値を指定して実行

### 利用可能な target 一覧

| target | 説明 |
|--------|------|
| `test-a` | Test workflow for target A |
| `test-b` | Test workflow for target B |
