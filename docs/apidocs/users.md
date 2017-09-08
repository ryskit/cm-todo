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
