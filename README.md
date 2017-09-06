# ToDo API

* Ruby version 2.4.1

* Database Postgresql 9.6.3

## ToDo API Documents

[todo/docs/published]フォルダの配下のindex.htmlをブラウザで開くとAPIドキュメントを確認できます。

### APIドキュメントを編集する場合

- [todo/docs/apidocs]配下にファイルを作成する
- [todo/docs/apidocs/layout.md]に、作成したファイル名を以下のように記載する
  - <% include ファイル名.md %>
- ドキュメントを書く
- 書いたドキュメントを一つのファイルに以下のコマンドでまとめる
  - [docs]内で ```gulp``` を実行
  - [docs/published]配下に、index.html, index.mdが生成される

※gulpを実行して、 http://localhost:8088 でドキュメントを確認することも可能
