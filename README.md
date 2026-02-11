# workflow-gateway

[![Pages Deploy](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment)
[![GitHub Release](https://img.shields.io/github/v/release/lurest-inc/workflow-gateway)](https://github.com/lurest-inc/workflow-gateway/releases)

Lurest の private workflows を `workflow_dispatch` で起動するための **Gateway**（入口）です。

📄 **ドキュメント（HTML版）**: [https://lurest-inc.github.io/workflow-gateway/](https://lurest-inc.github.io/workflow-gateway/)

| ワークフロー | md | html |
|------------|------------|------------|
| Claude Gateway | [docs/claude-gateway.md](docs/claude-gateway.md) | [/claude-gateway](https://lurest-inc.github.io/workflow-gateway/claude-gateway) |

## セットアップ手順

このワークフローを利用するには、以下の手順が必要です。

### 利用者（リポジトリのオーナー）が行う手順

#### 1. リポジトリに @mabubu0203 を招待する

リポジトリの **Settings > Collaborators and teams** から @mabubu0203 を招待してください。

##### ロール要件

管理者（@mabubu0203）にはリポジトリへの以下の権限が必要です。

| 作業 | 必要なロール |
|------|-----------|
| ブランチ作成、コミット、PR作成 | **Write** 以上 |
| Secret の登録（Settings UI） | **Admin** |

> **推奨**: 管理者には **Admin** ロール を付与することをお勧めします。その方が作業がスムーズです。

#### 2. @mabubu0203 に PAT 発行を依頼する

Issue またはメッセージで @mabubu0203 に以下の内容を依頼してください。

- 利用者のリポジトリへのアクセス権を持つ PAT（`OWNER_TOKEN` として登録）
- `lurest-inc/private-workflows` へのアクセス権を持つ PAT（`LUREST_DISPATCH_TOKEN` として登録）

### @mabubu0203（管理者）が行う手順

@mabubu0203 は以下のドキュメントに従って作業を進めてください。

> [docs/setup-for-admin.md](docs/setup-for-admin.md) を参照してください。

主な作業内容：
1. 招待を承認する
2. GitHub Actions を有効化する
3. 2つの PAT を発行する
   - 利用者のリポジトリ用
   - `lurest-inc/private-workflows` 用
4. 利用者のリポジトリに Secret を登録する
   - `OWNER_TOKEN`
   - `LUREST_DISPATCH_TOKEN`
5. 利用者のリポジトリに Workflow ファイルと Claude Code コマンド設定を追加する
   - `.github/workflows/setup-claude.yml`
   - `.claude/commands/`（ブランチを切ってコミット）

