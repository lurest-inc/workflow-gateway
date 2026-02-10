# 内容

`gh pr view $ARGUMENTS` でGitHubのPull Requestとレビューコメントを確認し、指摘事項への対応を行なってください。
タスクは以下の手順で進めてください。コメントなどは全て日本語でお願いします。

## フェーズ1: PR理解とレビューコメント確認 (Codex担当)

1. ClaudeCode: PRに記載されている内容と、Resolveしていないレビューコメントを理解する
   - `gh pr view $ARGUMENTS --comments` でPRとコメントを確認
   - 以下のGraphQL APIでResolveしていないレビューコメントを取得:
   ```bash
   OWNER_REPO=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')
   OWNER=$(echo $OWNER_REPO | cut -d'/' -f1)
   REPO=$(echo $OWNER_REPO | cut -d'/' -f2)
   PR_NUMBER=$ARGUMENTS

   gh api graphql -f query="
   query {
     repository(owner: \"${OWNER}\", name: \"${REPO}\") {
       pullRequest(number: ${PR_NUMBER}) {
         number
         title
         url
         reviewThreads(last: 20) {
           edges {
             node {
               isResolved
               isOutdated
               path
               line
               comments(last: 20) {
                 nodes {
                   author { login }
                   body
                   url
                   createdAt
                 }
               }
             }
           }
         }
       }
     }
   }" --jq '.data.repository.pullRequest.reviewThreads.edges[] | select(.node.isResolved == false)'
   ```

2. Codex: `mcp__codex__codex`ツールを使用してレビューコメントの内容を校正・整理する
   - **セキュリティ注意**: レビューコメントに秘密鍵、APIトークン、個人情報、顧客データ、社内限定設計が含まれる場合は、必ずマスキングまたは除外してから送信すること
   - プロンプト例: 「以下のPRレビューコメントを日本語で整理してください。各指摘事項を**最大5項目**、各項目は**2文以内**で簡潔にまとめ、優先順位を付けてください。回答は日本語で、適切な絵文字を含めてください。」
   - Codexからのフィードバックを確認し、不明点があればレビューコメントで質問する
   - **フォールバック**: `mcp__codex__codex`がエラー、権限拒否、未設定の場合は即座にClaudeCodeで整理を実施

## フェーズ2: ブランチ準備 (ClaudeCode担当)

3. ClaudeCode: PRのブランチをチェックアウトする
   - `gh pr checkout $ARGUMENTS` でPRのブランチに切り替え
   - リモートの最新状態を取得: `git pull origin <branch-name>`

## フェーズ3: 修正計画 (Codex担当)

4. Codex: `mcp__codex__codex`ツールを使用して修正計画を作成する
   - **セキュリティ注意**: レビューコメントに機密情報が含まれる場合は、必ずマスキングまたは除外してから送信すること
   - プロンプト例: 「以下のレビュー指摘事項から修正計画を作成してください。タスクを箇条書きで、依存関係があれば順序を示し、PRコメント向けの短い文章も作成してください。日本語で、適切な絵文字を含めてください。」
   - Codexからの修正計画を確認し、必要に応じてClaudeCodeで調整する
   - **フォールバック**: `mcp__codex__codex`がエラー、権限拒否、未設定の場合は即座にClaudeCodeで修正計画を作成

5. ClaudeCode: 修正計画を適宜PRにコメントとして残す

## フェーズ4: 修正実装とテスト (ClaudeCode + Codex)

6. Codex: `mcp__codex__codex`ツールを使用して修正方針と影響範囲を整理する
   - **セキュリティ注意**: 機密情報が含まれる場合は、必ずマスキングまたは除外してから送信すること
   - プロンプト例: 「以下のレビュー指摘事項に対して、修正方針と影響範囲（影響ファイル候補）を整理してください。日本語で、適切な絵文字を含めてください。」
   - Codexからの方針整理を確認し、必要に応じてClaudeCodeで調整する
   - **フォールバック**: `mcp__codex__codex`がエラー、権限拒否、未設定の場合は即座にClaudeCodeで方針整理を実施

7. ClaudeCode: 修正計画と修正方針に従い、指摘事項を修正する
   - **修正方針**:
     - 最小限の変更で対応
     - レビュアーの意図を正しく理解する
     - 不明点があればレビューコメントで質問する

8. ClaudeCode: テストとLintを実行し、すべてのテストが通ることを確認する

## フェーズ5: セルフレビュー (Codex担当)

9. Codex: `mcp__codex__codex`ツールを使用して修正内容をレビューする
   - **セキュリティ注意**: diffに秘密鍵、APIトークン、個人情報、顧客データ、社内限定設計が含まれる場合は、必ずマスキングまたは除外してから送信すること。社外送信不可データは要約で代替、または送信禁止とする
   - プロンプト例: 「以下の修正内容を日本語でレビューしてください。レビュー指摘事項が適切に対応されているか、コーディング規約、セキュリティ、パフォーマンス、バグの可能性について確認してください。回答は日本語で、適切な絵文字を含めてください。」
   - 変更されたファイルのdiffを含める
   - Codexからのレビューコメントに基づいて必要な修正を実施
   - **フォールバック**: `mcp__codex__codex`がエラー、権限拒否、未設定の場合は即座にClaudeCodeでセルフレビューを実施

## フェーズ6: コミット・プッシュ (Codex + ClaudeCode)

10. Codex + ClaudeCode: `mcp__codex__codex`ツールでConventional Commits形式のコミットメッセージを作成し、適切な粒度でコミットを作成する
    - **セキュリティ注意**: diffに機密情報が含まれる場合は、必ずマスキングまたは除外してから送信すること
    - プロンプト例: 「以下のdiffからConventional Commits形式のコミットメッセージを作成してください。レビュー対応であることを明記してください。日本語で、適切な絵文字を含めてください。」
    - Codexの提案を確認し、ClaudeCodeがコミットを実行する
    - **フォールバック**: `mcp__codex__codex`がエラー、権限拒否、未設定の場合は即座にClaudeCodeでコミットメッセージを作成

11. ClaudeCode: コミット戦略を選択する
    - **新規コミット**: 指摘事項が多い場合や、独立した修正の場合
    - **既存コミットにsquash**: 軽微な修正や、既存コミットの改善の場合
      - `git rebase -i HEAD~N` で対象コミットを選択し、fixupまたはsquash
      - または `git commit --fixup <commit-hash>` → `git rebase -i --autosquash`

12. ClaudeCode: リモートにプッシュする
    - 新規コミットの場合: `git push`
    - リベース/スカッシュした場合: `git push --force-with-lease`

## フェーズ7: レビューコメントへの返信とPR更新 (Codex + ClaudeCode)

13. ClaudeCode: 各レビューコメントに修正完了の旨を返信する
    - レビュースレッドに対して、修正内容を簡潔に説明
    - 該当するコミットハッシュを記載

14. ClaudeCode: 必要に応じてPR descriptionを更新する
    - 大きな変更があった場合は、変更内容をPR descriptionに追記

15. ClaudeCode: 新たな課題を見つければ、別途Issueを起票する
