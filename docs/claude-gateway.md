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

### Issue / PR / コメントによる操作

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
    uses: lurest-inc/workflow-gateway/.github/workflows/claude-gateway.yml@v0.0.10
    secrets:
      owner_token: ${{ secrets.OWNER_TOKEN }}
      LUREST_DISPATCH_TOKEN: ${{ secrets.LUREST_DISPATCH_TOKEN }}
```

### Daily Docs Maintenance（毎日自動ドキュメント保守）

```yaml
name: Daily Docs Maintenance

on:
  # 毎日 JST 03:30（UTC 18:30）に実行
  schedule:
    - cron: "30 18 * * *"

# 二重起動を防止
concurrency:
  group: daily-docs
  cancel-in-progress: false

jobs:
  daily-docs:
    uses: lurest-inc/workflow-gateway/.github/workflows/claude-gateway.yml@v0.0.10
    secrets:
      owner_token: ${{ secrets.OWNER_TOKEN }}
      LUREST_DISPATCH_TOKEN: ${{ secrets.LUREST_DISPATCH_TOKEN }}
```

> **注意**: `schedule` トリガーの場合、`event_name` が `schedule` として渡されるため、`cc-gateway-receiver.yml` は自動的に `daily-docs` ジョブにルーティングします。

## 使い方

### Issue 自動実装
1. 呼び出しサンプルを参考に、リポジトリに `claude.yml` を作成する
2. Issue に `claude-implement` ラベルを付ける
3. Claude が自動的に Issue の内容を実装して PR を作成します

### PR レビュー修正
1. 呼び出しサンプルを参考に、リポジトリに `claude.yml` を作成する
2. PR に `claude-fix-review` ラベルを付ける
3. Claude が自動的にレビューコメントを読んで修正します

### インタラクティブ操作
1. 呼び出しサンプルを参考に、リポジトリに `claude.yml` を作成する
2. Issue または PR のコメントで `@claude` とメンションして指示を書く
3. Claude が指示に従って作業を実行します

### Daily Docs Maintenance（毎日自動ドキュメント保守）
1. 呼び出しサンプルを参考に、リポジトリに `daily-docs.yml` を作成する
2. cron スケジュール（例: 毎日 JST 03:30 = `30 18 * * *`）で自動実行される
3. Claude が対象リポジトリのドキュメントを自動的に保守・更新します
4. 実行ゲート: JST 深夜帯（00:00〜05:59）かつ当日1回のみ実行されます
