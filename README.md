# workflow-gateway

[![Pages Deploy](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment/badge.svg)](https://github.com/lurest-inc/workflow-gateway/actions/workflows/pages/pages-build-deployment)

Lurest の private workflows を `workflow_dispatch` で起動するための **Gateway**（入口）です。

📄 **ドキュメント**: [https://lurest-inc.github.io/workflow-gateway/](https://lurest-inc.github.io/workflow-gateway/)

## 利用者側（あなたのリポジトリ）でやること

### 1. Secret を追加
リポジトリの `Settings` → `Secrets and variables` → `Actions` で以下を追加します。

- `LUREST_DISPATCH_TOKEN` : Lurest が発行した fine-grained PAT

> ※ PAT は `lurest-inc/private-workflows` に対して **Actions: write** が必要です。

### 2. workflow を呼び出す

```yml
jobs:
  lurest:
    uses: lurest-inc/workflow-gateway/.github/workflows/gateway.yml@v1
    secrets:
      LUREST_DISPATCH_TOKEN: ${{ secrets.LUREST_DISPATCH_TOKEN }}
    with:
      workflow_file: core.yml
      ref: main
      inputs_json: '{"example":"value"}'
```
