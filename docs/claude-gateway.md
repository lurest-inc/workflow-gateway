# Claude Gateway

## 概要

`claude-gateway.yml` は、Claude による自動化を外部リポジトリからシンプルに利用できる統合エントリーポイントです。
`lurest-inc/private-workflows` の `cc-gateway-receiver.yml` を reusable workflow として呼び出します。

## トリガー

`workflow_call`（他のワークフローから呼び出す形式）

## 必要な Secrets

| Secret名 | 必須 | 説明 |
|---------|:----:|------|
| `GITHUB_TOKEN` | ✅ | GitHub Actions が自動提供するトークン。明示的な設定は不要ですが、呼び出し元で渡す必要があります。 |
| `LUREST_DISPATCH_TOKEN` | 任意* | `lurest-inc/private-workflows` へのアクセス権を持つ PAT。リポジトリ管理者から取得してください。 |

> * ワークフロー定義上は任意ですが、未設定の場合でも `gatewayGuard` ジョブで失敗するため、通常の利用時は設定することを強く推奨します。
> **注意**: `LUREST_DISPATCH_TOKEN` が未設定、無効、またはアクセス権がない場合、`gatewayGuard` ジョブでワークフローが停止します。
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
    types: [opened, edited, labeled, unlabeled]
  pull_request:
    types: [opened, edited, labeled, unlabeled, synchronize]
  issue_comment:
    types: [created]
  pull_request_review_comment:
    types: [created]

jobs:
  claude:
    uses: lurest-inc/workflow-gateway/.github/workflows/claude-gateway.yml@v0.0.3
    secrets:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
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
