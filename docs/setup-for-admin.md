# 管理者向けセットアップ手順（@mabubu0203 担当）

利用者から依頼を受けた際の作業手順です。

## 1. 招待を承認する

利用者のリポジトリから招待が届いたら、GitHub の通知から承認してください。

## 2. PAT（Personal Access Token）を発行する

`lurest-inc/private-workflows` へのアクセス権を持つ fine-grained PAT を発行します。

1. GitHub の **Settings > Developer settings > Personal access tokens > Fine-grained tokens** を開く
2. **Generate new token** をクリック
3. 以下の設定で発行する

| 項目 | 設定値 |
|------|--------|
| Resource owner | `lurest-inc` |
| Expiration | `30 days`（30日ごとに再発行が必要） |
| Repository access | `Only select repositories` → `private-workflows` を選択 |
| Permissions > Actions | `Read and write` |
| Permissions > Contents | `Read-only` |

> **注意**: PAT の有効期限は **30日間**です。期限切れ前に再発行して利用者に共有してください。

4. 発行された PAT を利用者のリポジトリへ登録する

## 3. 利用者のリポジトリに Secret を登録する

招待を承認したリポジトリの **Settings > Secrets and variables > Actions** を開き、以下の Secret を登録してください。

| Secret名 | 値 |
|---------|---|
| `LUREST_DISPATCH_TOKEN` | 手順2で発行した PAT |
