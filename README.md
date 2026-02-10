# workflow-gateway

[![Pages Deploy](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment)

Lurest の private workflows を `workflow_dispatch` で起動するための **Gateway**（入口）です。

📄 **ドキュメント（HTML版）**: [https://lurest-inc.github.io/workflow-gateway/](https://lurest-inc.github.io/workflow-gateway/)

| ワークフロー | ドキュメント |
|------------|------------|
| Claude Gateway | [docs/claude-gateway.md](docs/claude-gateway.md) |

## 共通セットアップ

各ワークフローを利用するには、リポジトリの **Settings > Secrets and variables > Actions** で以下の Secret を登録してください。

| Secret名 | 説明 |
|---------|------|
| `GITHUB_TOKEN` | GitHub Actions が自動提供するトークン。明示的な設定は不要ですが、ワークフローで渡す必要があります。 |
| `LUREST_DISPATCH_TOKEN` | `lurest-inc/private-workflows` へのアクセス権を持つ PAT（Personal Access Token）。リポジトリ管理者から取得してください。 |
