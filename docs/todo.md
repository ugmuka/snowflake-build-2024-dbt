# ゴール
- mart_ml_featureが提供できる

# 見てもらいたいこと

## dbt Cloudを使ったモデル開発の雰囲気
テストの仕組みを使って品質を保証しながら開発ができる（CIとDeploy）
SmartCIの良さ（CI用意って大変だよね

- ちょっとした修正
- それに関連したテストの追加
- コミット
- PRの作成
- CIのパス
- merge
- merge job 動く

## データカタログ上でドキュメントや品質が担保されたテーブル（モデル）が出来上がっているのが確認できるよ
ドキュメントやテスト、exposureでデータカタログの体験を見れる

# 諦めること
- semantic_layerは諦める（時間が必要そう

# 残タスク
- [ ] (mukai) stagingへのテスト追加
- [ ] (mukai) mart_ml_featureへのテストとドキュメントの追加
- [ ] (mukai) exporsureの設定
- [ ] (takimo) merge jobの設定と動作確認
- [ ] (takimo) 当日行うちょっとした修正の計画（事前に試しておく）
- [ ] (takimo) sqlfluffの設定変更