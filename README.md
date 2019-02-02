# Name
RailsBoards

# Overview
記事の投稿サイトです。
Ruby on Railsを使って作った掲示板サイトです。
## Description
・ログインしていないユーザーは記事の閲覧だけできます。

・記事と自分のプロフィールに画像をアップロードできます。

・ユーザー登録すると記事の投稿やコメントをすることができます。

・ログインしているユーザーは自分の記事の編集と削除ができます。

・タグを作成して記事をタグで分けることができます。

・ログインユーザーが投稿した記事をcsvファイルで出力できます。

.ユーザーのcsvデータをRakeタスクでインポートできます。

・各ユーザーには最初に5ポイント付与されており記事を新規作成ごとに1ポイント消費します。
0ポイントになったら記事を投稿できなくなります。

・ポイントはRakeタスクで各ユーザーに5ポイント加えることができます。
