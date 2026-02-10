# workflow-gateway

[![Pages Deploy](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment)
[![GitHub Release](https://img.shields.io/github/v/release/lurest-inc/workflow-gateway)](https://github.com/lurest-inc/workflow-gateway/releases)

Lurest の private workflows を `workflow_dispatch` で起動するための **Gateway**（入口）です。

📄 **ドキュメント（HTML版）**: [https://lurest-inc.github.io/workflow-gateway/](https://lurest-inc.github.io/workflow-gateway/)

| ワークフロー | md | html |
|------------|------------|------------|
| Claude Gateway | [docs/claude-gateway.md](docs/claude-gateway.md) | [/claude-gateway](https://lurest-inc.github.io/workflow-gateway/claude-gateway) |

## 共通セットアップ

各ワークフローを利用するには、リポジトリの **Settings > Secrets and variables > Actions** で以下の Secret を登録してください。

| Secret名 | 説明 |
|---------|------|
| `LUREST_DISPATCH_TOKEN` | `lurest-inc/private-workflows` へのアクセス権を持つ PAT（Personal Access Token）。リポジトリ管理者から取得してください。 |

> **注意**: `LUREST_DISPATCH_TOKEN` が無効またはアクセス権がない場合、ワークフローの実行は `gatewayGuard` ジョブで停止されます。

## 依頼について

このワークフローを利用するには、事前に以下の手順を踏む必要があります。

### 1. リポジトリに @mabubu0203 を招待する

リポジトリの **Settings > Collaborators and teams** から @mabubu0203 を招待してください。

Secret の登録には **Admin** ロールが必要です。以下を参考にロールを設定してください。

| ロール | Secret の登録（Settings UI） |
|-------|:---:|
| Read / Triage / Write / Maintain | ✗ |
| **Admin** | ✅ |

> **注意**: @mabubu0203 を招待する際は、ロールを **Admin** に設定してください。

### 2. @mabubu0203 に PAT 発行を依頼する

Issue またはメッセージで @mabubu0203 に `LUREST_DISPATCH_TOKEN` の発行を依頼してください。
@mabubu0203 が PAT の発行から Secret の登録まで行います。

> @mabubu0203 側の作業内容は [docs/setup-for-admin.md](docs/setup-for-admin.md) を参照してください。

