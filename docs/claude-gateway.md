# Claude Gateway

## 概要

`claude-gateway.yml` は、Claude による自動化を外部リポジトリからシンプルに利用できる統合エントリーポイントです。
`lurest-inc/private-workflows` の `cc-gateway-receiver.yml` を reusable workflow として呼び出します。

## トリガー

`workflow_call`（他のワークフローから呼び出す形式）

## 必要な Secrets

| Secret名 | 必須 | 説明 |
|---------|:----:|------|
| `OWNER_TOKEN` | ✅ | 利用者のリポジトリへのアクセス権を持つ PAT。`lurest-inc/private-workflows` でのクロスリポジトリのチェックアウトと ClaudeCodeAction の実行に必要です。 |
| `LUREST_DISPATCH_TOKEN` | ✅  | `lurest-inc/private-workflows` へのアクセス権を持つ PAT。gateway が private-workflows のワークフローを呼び出すために必要です。 |

## ジョブ構成

```
gatewayGuard → gateway
```

| ジョブ名 | 説明 |
|---------|------|
| `gatewayGuard` | `LUREST_DISPATCH_TOKEN` が `lurest-inc/private-workflows` にアクセスできるか事前検証する |
| `gateway` | `cc-gateway-receiver.yml` を呼び出してイベントをルーティングする |

## 呼び出しサンプル

```yaml
name: Setup Claude

on:
  issues:
    types: [opened, labeled]
  pull_request:
    types: [opened, labeled]
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]

jobs:
  claude:
    uses: lurest-inc/workflow-gateway/.github/workflows/claude-gateway.yml@v0.0.6
    secrets:
      owner_token: ${{ secrets.OWNER_TOKEN }}
      LUREST_DISPATCH_TOKEN: ${{ secrets.LUREST_DISPATCH_TOKEN }}
```

## 使い方

### Issue 自動実装
1. Issue に `claude-implement` ラベルを付ける
2. Claude が自動的に Issue の内容を実装して PR を作成します

### PR レビュー修正
1. PR に `claude-fix-review` ラベルを付ける
2. Claude が自動的にレビューコメントを読んで修正します

### インタラクティブ操作
1. Issue または PR のコメントで `@claude` とメンションして指示を書く
2. Claude が指示に従って作業を実行します
