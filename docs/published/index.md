FORMAT: 1A

## ユーザーの新規作成 [/v1/signup]

### ユーザ登録 [POST]

#### 処理概要

* ユーザ情報を新しく登録する。
* 登録に成功した場合、アクセストークン、リフレッシュトークン、リフレッシュトークンの期限(UnixTime) を返す

+ Request (application/json)

   + Headers

       Accept: application/json

   + Attributes
        + user: 
            + name: test user (string, required, maximum: 100) - 名前
            + email: test@example.com (string, required, maximum: 255) - メールアドレス (pattern: /\A[\w\+\-\.]+[a-zA-Z\d]+@[a-zA-Z\d\-]+(\.[a-zA-Z\d\-]+)*\.[a-zA-Z]+\z/i)
            + password: abc123 (string, required, minimum: 6) - パスワード
            + password_confirmation: abc123 (string, required, minimum: 6) - 確認用パスワード

+ Response 201 (application/json)

   + Attributes
        + status: OK 
        + access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiYjk2ZWM3MDgxYmRkYjViNGI1OGZlYjU0OGZiNzFkZDczY2RiODFmYWZhZjg4ZGE3YTJiYzM4YTM3ODc0NGI2MGI1ZjQ0NWFiZGRhYzcyMWFhYWFmYzg5MWExMDhiMDEwMzVkYTllOTkzNzE3YTM1MDA3MGVlNWY3YmFhNjY0MWUiLCJuYW1lIjoiZGhoNCIsImlzcyI6IlRvRG8gQXBwIiwic3ViIjoiUmVmcmVzaCBUb2tlbiIsImV4cCI6MTUwNDcyMjgwOSwibmdmIjoxNTA0NjM2NDA0LCJpYXQiOjE1MDQ2MzY0MDl9.ZAGXoLnIiP5DF4Wuwyua70xbfXQp3JsBjL5RJ53KUzlU0ehQnnDLIQeRQ8pwM4J9r0U8sJQW2p2UdTxxHc3emw (string, required) - アクセストークン
        + refresh_token: 855583144be6e3b592b8b9afc551e868b64c455b50e50870f785308c4f7d8fe3ef42a4e71d6083f59566cc9b8f6fd6286d7854793697a116a24f6f4c27aa277f643d05bfe7e46d785684c9793cbbba92b44e7da5229ba5238e1b9c7c134131ffe81cbf181c0b35385fe648405ea8a051167d73800f68460cd665377bf321da45 (string , required) - リフレッシュトークン
        + refresh_token_exp: 1536172409 (number) - リフレッシュトークンの期限 UnixTime (number)
        
+ Response 400 (application/json)

    + Attributes
        + status: NG
        + code: 400(number)
        + error: Bad Request
        + messages:
            + name:
                + エラーメッセージ
            + email:
                + エラーメッセージ
            + password:
                + エラーメッセージ
            + password_confirmation: 
                + エラーメッセージ


## ユーザーの名前・メールアドレスを更新する [/v1/settings/account]

### ユーザーの名前・メールアドレスの更新 [PATCH]

#### 処理概要

* ユーザーの名前、もしくは、メールアドレスをリクエストすると更新される。
* 更新に成功した場合、ユーザーの名前、メールアドレスがレスポンスとして返る

+ Request (application/json)

   + Headers

       Accept: application/json
       Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw

   + Attributes
        + user: 
            + name: test user (string, optional, maximum: 100) - 名前
            + email: test@example.com (string, optional, maximum: 255) - メールアドレス (pattern: /\A[\w\+\-\.]+[a-zA-Z\d]+@[a-zA-Z\d\-]+(\.[a-zA-Z\d\-]+)*\.[a-zA-Z]+\z/i)

+ Response 201 (application/json)

{
    "user": {
        "name": "example_user",
        "email": "example1@example.com",
    }
}


## ユーザーのパスワードを更新する [/v1/settings/password]

### ユーザーのパスワード更新 [PATCH]

#### 処理概要

* ユーザーの古いパスワード、新しいパスワード、確認パスワードをリクエストすると更新される。
* 更新に成功した場合、空のJSONがレスポンスとして返る

+ Request (application/json)

   + Headers

       Accept: application/json
       Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw

   + Attributes
        + user: 
            + old_password: password (string, required, minimum: 6) - 古いパスワード
            + password: newpassword (string, required, minimum: 6, confirmation: true) - 新しいパスワード
            + password_confirmation: newpassword (string, required, minimum: 6) - 確認用パスワード

+ Response 204 (application/json)

{}

## ユーザーの認証・認可 [/v1/auth/authorize]

### ユーザーのアクセストークン・リフレッシュトークン取得 [POST]

#### 処理概要

* 認証に成功すると、アクセストークンとリフレッシュトークを返す。
* 認証には、ユーザーの email, passwordを用いて行う。

+ Request (application/json)

    + Headers
    
        Accept(application/json)

    + Attributes
        + user (required)
            + email: test_user@example.com - メールアドレス
            + password: abc123 - パスワード

+ Response 200 (application/json)

   + Attributes
        + user (required)
            + token_type: bearer (string, required)
            + access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ2OTg5MjEsIm5nZiI6MTUwNDYxMjUxNiwiaWF0IjoxNTA0NjEyNTIxfQ.9ME9O34d6ft779H9vOJYE12eQL2ifL02TwmAmUkwfZShLqTBTFGEpL_wQztT9jKRaRZStjwtFLOLWQ_6swdbKg (string, required)
            + refresh_token: 61f00443c2228947d2e786b6e0b67311bb47e7ecf8926fc93477eeec8f942da9348395fced13d7f58a2c336ab594def5603e788d46974685f056e02a14b434930b3d4885b31e8ea15a5b03ecfa5995dc52fe575a4a7d86078d19455c258fdf1ee1a4bf92c4db4372d6f3ae5dc1e250ad12550cf84c4057ead4113fd27a8c4ec5 (string, required)
            + refresh_token_exp (number, required)
            

## ユーザーのアクセストークンの更新 [/v1/auth/token]

### ユーザーのアクセストークン更新 [POST]

#### 処理概要

* ユーザーからリクエストされたリフレッシュトークンが有効な場合、新しいアクセストークンを返す

+ Request (application/json)

    + Headers
    
        Accept(application/json): 
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiYjk2ZWM3MDgxYmRkYjViNGI1OGZlYjU0OGZiNzFkZDczY2RiODFmYWZhZjg4ZGE3YTJiYzM4YTM3ODc0NGI2MGI1ZjQ0NWFiZGRhYzcyMWFhYWFmYzg5MWExMDhiMDEwMzVkYTllOTkzNzE3YTM1MDA3MGVlNWY3YmFhNjY0MWUiLCJuYW1lIjoiZGhoNCIsImlzcyI6IlRvRG8gQXBwIiwic3ViIjoiUmVmcmVzaCBUb2tlbiIsImV4cCI6MTUwNDcyMjgwOSwibmdmIjoxNTA0NjM2NDA0LCJpYXQiOjE1MDQ2MzY0MDl9.ZAGXoLnIiP5DF4Wuwyua70xbfXQp3JsBjL5RJ53KUzlU0ehQnnDLIQeRQ8pwM4J9r0U8sJQW2p2UdTxxHc3emw

+ Response 200 (application/json)

   + Attributes
        + token_type: bearer (string, required)
        + access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ2OTg5MjEsIm5nZiI6MTUwNDYxMjUxNiwiaWF0IjoxNTA0NjEyNTIxfQ.9ME9O34d6ft779H9vOJYE12eQL2ifL02TwmAmUkwfZShLqTBTFGEpL_wQztT9jKRaRZStjwtFLOLWQ_6swdbKg (string, required)


## ユーザーのリフレッシュトークンを無効化する [/v1/auth/revoke]

### ユーザーのリフレッシュトークンの無効化 [POST]

#### 処理概要

* 認証に成功すると、空のJSONが返ってくる
* 認証には、ユーザーの email, passwordを用いて行う。

+ Request (application/json)

    + Headers
    
        Accept(application/json)
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiYjk2ZWM3MDgxYmRkYjViNGI1OGZlYjU0OGZiNzFkZDczY2RiODFmYWZhZjg4ZGE3YTJiYzM4YTM3ODc0NGI2MGI1ZjQ0NWFiZGRhYzcyMWFhYWFmYzg5MWExMDhiMDEwMzVkYTllOTkzNzE3YTM1MDA3MGVlNWY3YmFhNjY0MWUiLCJuYW1lIjoiZGhoNCIsImlzcyI6IlRvRG8gQXBwIiwic3ViIjoiUmVmcmVzaCBUb2tlbiIsImV4cCI6MTUwNDcyMjgwOSwibmdmIjoxNTA0NjM2NDA0LCJpYXQiOjE1MDQ2MzY0MDl9.ZAGXoLnIiP5DF4Wuwyua70xbfXQp3JsBjL5RJ53KUzlU0ehQnnDLIQeRQ8pwM4J9r0U8sJQW2p2UdTxxHc3emw

    + Attributes
        + user (required)
            + email: test_user@example.com - メールアドレス
            + password: abc123 - パスワード

+ Response 200 (application/json)

{}

## タスク情報のリストを取得 [/v1/tasks{?page,per,q,title,content,checked,next_days}]

### タスク情報のリスト取得 [GET]

#### 処理概要

* 条件で絞り込まれた複数のタスクを取得する。
* 自ユーザーが登録したタスクのみ取得できる。

+ Parameters

    + page: 1 (number, optional) - タスクリスト表示ページ数
    + per: 5 (number, optional) - 1ページあたりに表示するタスクの数
    + q: keyword (string, optional) - タスクのタイトル・コンテンツから部分一致するタスクを絞り込む
    + checked: true (boolean, optional) - タスクが済みかどうか
    + next_days: 7 (number, optional) - タスクの期限が設定されており、期日が何日後以内のタスクを絞り込む
    + expired: true (boolean, optional) - タスクの有効期限が過ぎているかどうかで絞り込む
    
+ Request (application/json)

    + Headers
        
        Accept: application/json
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw

+ Response 200 (application/json)

{
    "tasks": [
        {
            "id": 4,
            "title": "update 2",
            "content": "content2",
            "due_to": null,
            "created_at": "2017-08-27T19:45:52.968+09:00",
            "updated_at": "2017-09-04T22:17:23.692+09:00",
            "user_id": 1,
            "checked": false
        },
        {
            "id": 5,
            "title": "title",
            "content": "content",
            "due_to": null,
            "created_at": "2017-08-27T19:45:53.699+09:00",
            "updated_at": "2017-08-27T19:45:53.699+09:00",
            "user_id": 1,
            "checked": false
        },...
    } 
}

## タスクの詳細情報を取得 [/v1/tasks/{id}]

### タスクの詳細情報取得 [GET]

#### 処理概要

* タスクのIDから詳細情報を取得する。

+ Parameters

    + id: 1 (number, required) - タスクのID

+ Request (application/json) 

    + Headers
        
        Accept: application/json
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw

+ Response 200 (application/json)

{
    "task": [
        {
            "id": 10,
            "title": "title",
            "content": "content",
            "due_to": null,
            "created_at": "2017-08-27T19:45:57.393+09:00",
            "updated_at": "2017-08-27T19:45:57.393+09:00",
            "user_id": 1,
            "checked": false
        }
    ]
}


## タスクの新規作成 [/v1/tasks/]

### タスクの新規作成 [POST]

#### 処理概要

* タスクを新しく作成する。
* 登録に成功した場合、登録されたタスクの情報を返す。

+ Request (application/json) 

    + Headers
        
        Accept: application/json
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw
        
    + Attributes
    
        + task: 
            + title: title (string, required, maximum: 200) - タイトル
            + content: content (string, required, maximum: 2000) - 内容
            + due_to: 2017-09-20 (string, optional) - 期日
            + checked: true (boolean, optional) - チェック(タスクが完了したかどうか)
    
+ Response 201 (application/json)

{
	"task": [
		{
			"id": 10,
			"title": "title",
			"content": "content",
			"due_to": null,
			"created_at": "2017-08-27T19:45:57.393+09:00",
			"updated_at": "2017-08-27T19:45:57.393+09:00",
			"user_id": 1,
			"checked": false
		}
	]
}


## タスクの情報を更新 [/v1/tasks/{id}]

### タスク情報更新 [PATCH]

#### 処理概要

* タスクの情報を更新する。
* 更新に成功した場合、更新後のタスクの情報を返す。

+ Parameters

    + id: 1 (number, required) - タスクのID

+ Request (application/json) 

    + Headers
        
        Accept: application/json
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw
        
    + Attributes
    
        + task: 
            + title: title (string, optional, maximum: 200) - タイトル
            + content: content (string, optional, maximum: 2000) - 内容
            + due_to: 2017-09-20 (string, optional) - 期日
            + checked: true (boolean, optional) - チェック(タスクが完了したかどうか)
    
+ Response 204 (application/json)

{
	"task": [
		{
			"id": 10,
			"title": "title",
			"content": "content",
			"due_to": null,
			"created_at": "2017-08-27T19:45:57.393+09:00",
			"updated_at": "2017-08-27T19:45:57.393+09:00",
			"user_id": 1,
			"checked": false
		}
	]
}


## タスクの削除 [/v1/tasks/{id}]

### タスクの削除 [DELETE]

#### 処理概要

* パラメータのidで指定されたタスクを削除する。
* 削除に成功した場合、空のJSONデータを返す。

+ Parameters

    + id: 1 (number, required) - タスクのID

+ Request (application/json) 

    + Headers
        
        Accept: application/json
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw
        
+ Response 204 (application/json)

{}

## プロジェクトの新規作成 [/v1/projects/]

### プロジェクトの新規作成 [POST]

#### 処理概要

* プロジェクトを新しく作成する。
* 登録に成功した場合、登録されたプロジェクトの情報を返す。

+ Request (application/json) 

    + Headers
        
        Accept: application/json
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw
        
    + Attributes
    
        + project: 
            + name: my project (string, required, maximum: 50) - プロジェクト名
    
+ Response 201 (application/json)

{
	"project": [
		{
			"id": 10,
			"name": "my project",
			"created_at": "2017-08-27T19:45:57.393+09:00",
			"updated_at": "2017-08-27T19:45:57.393+09:00",
			"user_id": 1,
		}
	]
}


## プロジェクトの更新 [/v1/projects/{id}]

### プロジェクトの更新処理 [PATCH]

#### 処理概要

* パラメータに渡されたIDのプロジェクトを更新する。
* 更新に成功した場合、更新されたプロジェクトの情報を返す。

+ Parameters

    + id: 1 (number, required) - プロジェクトのID

+ Request (application/json) 

    + Headers
        
        Accept: application/json
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw
        
    + Attributes
    
        + project: 
            + name: update my project (string, optional, maximum: 50) - プロジェクト名
    
+ Response 200 (application/json)

{
	"project": [
		{
			"id": 10,
			"name": "updated my project",
			"created_at": "2017-09-27T19:45:57.393+09:00",
			"updated_at": "2017-09-27T19:45:57.393+09:00",
			"user_id": 1,
		}
	]
}


## プロジェクトの削除 [/v1/projects/{id}]

### プロジェクトの削除 [DELETE]

#### 処理概要

* パラメータのidで指定されたプロジェクトを削除する。
* 削除に成功した場合、空のJSONデータを返す。
* 自身のプロジェクト以外を削除しようとすると400エラーとなる。

+ Parameters

    + id: 1 (number, required) - プロジェクトのID

+ Request (application/json) 

    + Headers
        
        Accept: application/json
        Authorization: Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ3ODM2ODAsIm5nZiI6MTUwNDY5NzI3NSwiaWF0IjoxNTA0Njk3MjgwfQ.qygveTT7moSxtn9NupD5UbNZ9ykhViUzWxEwjdkcyNJ00Zx3phLgcx98cPqs2RvevFqmeBUBohu635FbkcqYsw
        
+ Response 204 (application/json)

{}

