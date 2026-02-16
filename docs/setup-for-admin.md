# 管理者向けセットアップ手順（@mabubu0203 担当）

利用者から依頼を受けた際の作業手順です。

## 1. 招待を承認する

利用者のリポジトリから招待が届いたら、GitHub の通知から承認してください。

## 2. GitHub Actions を有効化する

利用者のリポジトリで GitHub Actions が有効になっているか確認し、必要に応じて有効化してください。

1. リポジトリの **Settings > Actions > General** を開く
2. **Actions permissions** セクションで以下を確認/設定する

| 設定項目 | 設定値 |
|---------|--------|
| Actions | Allow all actions and reusable workflows |

3. **Workflow permissions** セクションで以下を設定する

| 設定項目 | 設定値 |
|---------|--------|
| Default permissions | Read and write permissions |
| Allow GitHub Actions to create and approve pull requests | ✅ 有効化 |

> **注意**: PR作成やコミットなどの自動化を行うため、これらの権限が必要です。

## 3. PAT（Personal Access Token）を発行する

### 利用者のリポジトリ

`利用者のリポジトリ` へのアクセス権を持つ fine-grained PAT を発行します。

1. GitHub の **Settings > Developer settings > Personal access tokens > Fine-grained tokens** を開く
2. **Generate new token** をクリック
3. 以下の設定で発行する

| 項目 | 設定値 |
|------|--------|
| Resource owner | （リポジトリのオーナー） |
| Expiration | `30 days`（30日ごとに再発行が必要） |
| Repository access | `Only select repositories` → 利用者のリポジトリを選択 |
| Permissions > Actions | `Read and write` |
| Permissions > Contents | `Read and write` |
| Permissions > Pull requests | `Read and write` |
| Permissions > Issues | `Read and write` |

> **注意**: PAT の有効期限は **30日間**です。期限切れ前に再発行して利用者に共有してください。

### lurest-inc/private-workflows

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

## 4. 利用者のリポジトリに Secret を登録する

招待を承認したリポジトリの **Settings > Secrets and variables > Actions** を開き、以下の Secret を登録してください。

| Secret名 | 値 |
|---------|---|
| `OWNER_TOKEN` | `利用者のリポジトリ` で発行した PAT |
| `LUREST_DISPATCH_TOKEN` | `lurest-inc/private-workflows` で発行した PAT |

## 5. 利用者のリポジトリに Workflow ファイルを追加する

Claude Gateway のワークフローファイルを利用者のリポジトリに追加します。

### 1. ブランチを作成する

```bash
git checkout -b setup/claude-gateway
```

### 2. ファイルを作成する

#### 2.1 ワークフローファイルを作成する

`.github/workflows/` ディレクトリを作成し、`.yml` を新規作成してください。

[docs/claude-gateway.md](../docs/claude-gateway.md) の「呼び出しサンプル」を参考にして下さい。

#### 2.2 Claude Code コマンド設定を追加する

`.claude/commands/` ディレクトリを作成し、private-workflows で利用するファイルを追加してください。

- actions/daily-docs-maintenance.md
- actions/exec-issue.md
- actions/fix-pr.md

### 3. コミットして Push する

```bash
git add .github/workflows/setup-claude.yml .claude/commands/
git commit -m "chore: add Claude Gateway workflow and commands"
git push origin setup/claude-gateway
```

### 4. Pull Request を作成する

GitHub で PR を作成し、レビュー後に デフォルト ブランチにマージしてください。

> **注意**: ワークフローが正しく動作することを確認してから、利用者に通知してください。
