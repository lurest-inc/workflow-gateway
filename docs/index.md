# Lurest Workflow Gateway ドキュメント

外部リポジトリから `lurest-inc/private-workflows` を安全に呼び出すための **Gateway** ワークフロー集です。

## ワークフロー一覧

| ワークフロー | 説明 | トリガー |
|------------|------|---------|
| [Claude Gateway](claude-gateway.md) | Claude による自動化の統合エントリーポイント | `workflow_call` |
| [Call Test](call-test.md) | private-workflows のテストワークフローを reusable workflow で呼び出す | `workflow_call` |
| [Dispatch Test](dispatch-test.md) | private-workflows のテストワークフローを手動で起動する | `workflow_dispatch` |

## はじめに

Claude による自動化を導入する場合は **[Claude Gateway](claude-gateway.md)** のページをご覧ください。

## リポジトリ

- GitHub: [lurest-inc/workflow-gateway](https://github.com/lurest-inc/workflow-gateway)
- README: [README.md](https://github.com/lurest-inc/workflow-gateway/blob/main/README.md)
