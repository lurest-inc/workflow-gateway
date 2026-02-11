# Changelog

## [0.0.5](https://github.com/lurest-inc/workflow-gateway/compare/v0.0.4...v0.0.5) (2026-02-11)


### バグ修正

* **workflows:** PAT検証をタグ参照に統一しAPI呼び出しを削減 ([#43](https://github.com/lurest-inc/workflow-gateway/issues/43)) ([f06c5d8](https://github.com/lurest-inc/workflow-gateway/commit/f06c5d80b80a990fd172e735e373ef502a9e5925))

## [0.0.4](https://github.com/lurest-inc/workflow-gateway/compare/v0.0.3...v0.0.4) (2026-02-11)


### その他の変更

* private-workflowsの参照バージョンをv0.0.4に更新し dispatch_token を追加する ([#40](https://github.com/lurest-inc/workflow-gateway/issues/40)) ([1dcca08](https://github.com/lurest-inc/workflow-gateway/commit/1dcca0899a52fae3bea56650ad1bb00a2c5472e3))

## [0.0.3](https://github.com/lurest-inc/workflow-gateway/compare/v0.0.2...v0.0.3) (2026-02-10)


### バグ修正

* **workflows:** GITHUB_TOKEN を owner_token にリネームし予約名衝突を解消する ([#37](https://github.com/lurest-inc/workflow-gateway/issues/37)) ([b94baba](https://github.com/lurest-inc/workflow-gateway/commit/b94baba5ca7b425c933d6430eae36c9fde456c3f))

## [0.0.2](https://github.com/lurest-inc/workflow-gateway/compare/v0.0.1...v0.0.2) (2026-02-10)


### 新機能

* Claude Gatewayエントリーポイントの実装 ([#26](https://github.com/lurest-inc/workflow-gateway/issues/26)) ([972b2d1](https://github.com/lurest-inc/workflow-gateway/commit/972b2d14a3954b55e1351bff3bfb7d4a66a705b7))
* dispatch-test.ymlの追加とREADME更新 ([#4](https://github.com/lurest-inc/workflow-gateway/issues/4)) ([9c24827](https://github.com/lurest-inc/workflow-gateway/commit/9c2482719676b299e9bae31956f890638879d059))
* gatewayGuardジョブを追加してアクセス制御を実装 ([#30](https://github.com/lurest-inc/workflow-gateway/issues/30)) ([6844dce](https://github.com/lurest-inc/workflow-gateway/commit/6844dce00ec7317b997811afb9f5457db48ecde7))


### バグ修正

* LUREST_DISPATCH_TOKEN を secrets から inputs に変更 ([#6](https://github.com/lurest-inc/workflow-gateway/issues/6)) ([c0ff80d](https://github.com/lurest-inc/workflow-gateway/commit/c0ff80d4ff4350a68508bc0d496d60647f35abed)), closes [#5](https://github.com/lurest-inc/workflow-gateway/issues/5)


### ドキュメント

* ワークフローごとの説明書をdocs/配下に整備する ([#32](https://github.com/lurest-inc/workflow-gateway/issues/32)) ([e9395e3](https://github.com/lurest-inc/workflow-gateway/commit/e9395e3c69f5ea5cdc1c403355f0a203bc7fa9a7))


### その他の変更

* private-workflowsの参照バージョンをv0.0.2に更新 ([#34](https://github.com/lurest-inc/workflow-gateway/issues/34)) ([8a856e5](https://github.com/lurest-inc/workflow-gateway/commit/8a856e5199a05c85b4c668495ce4c7b36ed64691))
* プロジェクトの初期セットアップ ([#2](https://github.com/lurest-inc/workflow-gateway/issues/2)) ([316efbc](https://github.com/lurest-inc/workflow-gateway/commit/316efbc33275557fa3502ef4ceb11a82157184d6))


### リファクタリング

* claude-gateway.ymlをworkflow_call形式に変更 ([#28](https://github.com/lurest-inc/workflow-gateway/issues/28)) ([d0e85a1](https://github.com/lurest-inc/workflow-gateway/commit/d0e85a1c3077fcf4e916a3c4266a0ea8e0f4370e))
