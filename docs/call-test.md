# Call Test

## 概要

`call-test.yml` は、`lurest-inc/private-workflows` 内のテスト用ワークフローを reusable workflow として呼び出すゲートウェイです。
`workflow_call` 形式で外部リポジトリから呼び出して使用します。

## トリガー

`workflow_call`（他のワークフローから呼び出す形式）

## Inputs

| 名前 | 必須 | デフォルト値 | 説明 |
|------|:----:|------------|------|
| `target` | - | `test-b` | 起動するワークフロー（`test-a` / `test-b`） |
| `message` | - | `Dispatched via workflow-gateway` | `private-workflows` 側へ渡すメッセージ |

## 必要な Secrets

| Secret名 | 必須 | 説明 |
|---------|:----:|------|
| `LUREST_DISPATCH_TOKEN` | ✅ | `lurest-inc/private-workflows` に対して `Actions: write` 権限を持つ fine-grained PAT |

## ジョブ構成

| ジョブ名 | 条件 | 説明 |
|---------|------|------|
| `call-test-b` | `inputs.target == 'test-b'` | `private-workflows/test-b.yml` を呼び出す |

## 呼び出しサンプル

```yaml
jobs:
  test:
    uses: lurest-inc/workflow-gateway/.github/workflows/call-test.yml@main
    with:
      target: test-b
      message: "Hello from my-repo"
    secrets:
      LUREST_DISPATCH_TOKEN: ${{ secrets.LUREST_DISPATCH_TOKEN }}
```
