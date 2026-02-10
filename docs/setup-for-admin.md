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
| Repository access | `Only select repositories` → `private-workflows` を選択 |
| Permissions > Actions | `Read and write` |

4. 発行された PAT を利用者に共有する

## 3. 利用者に PAT を共有する

発行した PAT を安全な方法（DM 等）で利用者に共有してください。
PAT は一度しか表示されないため、共有前にコピーしておくこと。

## 4. 利用者側の登録完了を確認する

利用者が `LUREST_DISPATCH_TOKEN` として Secret を登録したら、ワークフローが正常に動作することを確認してください。
