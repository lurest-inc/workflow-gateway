# 内容

`gh issue view $ARGUMENTS` でGitHubのIssueの内容を確認し、タスクの遂行を行なってください。
タスクは以下の手順で進めてください。コメントなどは全て日本語でお願いします。

## 事前チェック: ラベル確認

0. `gh issue view $ARGUMENTS --json labels` で Issue のラベルを確認する
   - `ai-checked` ラベルが **付いていない** 場合は、以下のメッセージをユーザーに表示して **処理を中断** する:
     ```
     ⚠️ Issue #$ARGUMENTS に `ai-checked` ラベルが付いていません。
     先に `/development:prepare-issue $ARGUMENTS` を実行して、Issue の校正・ラベル付けを完了させてください。
     ```
   - `ai-checked` ラベルが **付いている** 場合は、フェーズ1以降に進む

## フェーズ1: Issue理解

> 💡 Issue の校正・ラベル付けは `/development:prepare-issue $ARGUMENTS` で事前に実施済みであることを前提とします。

1. ClaudeCode: `gh issue view $ARGUMENTS` で Issue に記載されている内容・ラベル・背景を理解する

## フェーズ2: ブランチ準備 (ClaudeCode担当)

2. ClaudeCode: デフォルトブランチにチェックアウトし、pullを行い、最新のリモートの状態を取得する
   ```bash
   DEFAULT_BRANCH=$(git rev-parse --abbrev-ref origin/HEAD | sed 's@^origin/@@')
   git checkout $DEFAULT_BRANCH
   git pull origin $DEFAULT_BRANCH
   ```
3. ClaudeCode: `issues/#$ARGUMENTS` でブランチを作成、チェックアウトする

## フェーズ3: タスク計画 (ClaudeCode担当)

4. ClaudeCode: Issue内容から実行計画を作成する
   - **セキュリティ注意**: Issueに秘密鍵、APIトークン、個人情報、顧客データ、社内限定設計が含まれる場合は、必ずマスキングまたは除外すること
   - タスクを箇条書きで、依存関係があれば順序を示す
5. ClaudeCode: 実行計画を適宜Issueにコメントとして残す

## フェーズ4: 実装とテスト (ClaudeCode担当)

6. ClaudeCode: 実装前の調査・方針を整理する
   - **セキュリティ注意**: 機密情報が含まれる場合は、必ずマスキングまたは除外すること
   - 実装方針と影響範囲（影響ファイル候補）を整理する
7. ClaudeCode: 実行計画と実装方針に従い、タスクを実行する

## フェーズ5: セルフレビュー (ClaudeCode担当)

8. ClaudeCode: 実装内容をレビューする
   - **セキュリティ注意**: diffに秘密鍵、APIトークン、個人情報、顧客データ、社内限定設計が含まれる場合は、必ずマスキングまたは除外すること
   - コーディング規約、セキュリティ、パフォーマンス、バグの可能性について確認する
   - 必要に応じて修正を実施する

## フェーズ6: コミット・プッシュ (ClaudeCode担当)

9. ClaudeCode: Conventional Commits形式のコミットメッセージを作成し、適切な粒度でコミットを作成する
    - **セキュリティ注意**: diffに機密情報が含まれる場合は、必ずマスキングまたは除外してからコミットすること
    - 各ファイルの変更内容に応じて適切なメッセージを作成し、コミットを実行する

## フェーズ7: PRと課題作成 (ClaudeCode担当)

10. ClaudeCode: PR descriptionを作成し、PRを作成する
    - **セキュリティ注意**: diffに機密情報が含まれる場合は、必ずマスキングまたは除外してから送信すること
    - 冒頭に `Closes #$ARGUMENTS` を入れ、変更内容を日本語で明確に記載する
11. ClaudeCode: 課題を見つければ、別途Issueを起票する