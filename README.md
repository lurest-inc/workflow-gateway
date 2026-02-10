# workflow-gateway

[![Pages Deploy](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment)

Lurest の private workflows を `workflow_dispatch` で起動するための **Gateway**（入口）です。

📄 **ドキュメント（HTML版）**: [https://lurest-inc.github.io/workflow-gateway/](https://lurest-inc.github.io/workflow-gateway/)

| ワークフロー | ドキュメント |
|------------|------------|
| Claude Gateway | [docs/claude-gateway.md](docs/claude-gateway.md) |
| Call Test | [docs/call-test.md](docs/call-test.md) |
| Dispatch Test | [docs/dispatch-test.md](docs/dispatch-test.md) |

## 🚀 Claude Gateway の使い方（推奨）

`claude-gateway.yml` は、Claude による自動化をシンプルに導入できる統合エントリーポイントです。

### セットアップ手順

#### 1. Secret を追加

リポジトリの **Settings > Secrets and variables > Actions** で以下の2つのSecretを登録します。

| Secret名 | 説明 |
|---------|------|
| `GITHUB_TOKEN` | GitHub Actionsが自動提供するトークン。明示的な設定は不要ですが、ワークフローで渡す必要があります。 |
| `LUREST_DISPATCH_TOKEN` | `lurest-inc/private-workflows` へのアクセス権を持つ PAT（Personal Access Token）。リポジトリ管理者から取得してください。 |

> **注意**: `LUREST_DISPATCH_TOKEN` が無効またはアクセス権がない場合、ワークフローの実行は `gatewayGuard` ジョブで停止されます。

#### 2. ワークフローファイルを作成

`.github/workflows/claude.yml` を以下の内容で作成します:

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
    uses: lurest-inc/workflow-gateway/.github/workflows/claude-gateway.yml@main
    secrets:
      GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      LUREST_DISPATCH_TOKEN: ${{ secrets.LUREST_DISPATCH_TOKEN }}
```

#### 3. 使い方

##### Issue自動実装
1. Issueに `claude-implement` ラベルを付ける
2. Claude が自動的にIssueの内容を実装してPRを作成します

##### PRレビュー修正
1. PRに `claude-fix-review` ラベルを付ける
2. Claude が自動的にレビューコメントを読んで修正します

##### インタラクティブ操作
1. IssueまたはPRのコメントで `@claude` とメンションして指示を書く
2. Claude が指示に従って作業を実行します

### メリット
- ✅ シンプルなセットアップ（コピー&ペーストで完了）
- ✅ 複雑なトリガー条件やif文が不要
- ✅ ラベル名や権限チェックは自動的に処理
- ✅ すべてのClaudeの機能を一つのワークフローで利用可能
