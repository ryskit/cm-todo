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


## ユーザーのリフレッシュトークンの更新 [/v1/auth/revoke]

### ユーザーのリフレッシュトークン更新 [POST]

#### 処理概要

* 認証に成功すると、以前のリフレッシュトークンを無効にして、新しいアクセストークンとリフレッシュトークを返す。
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

   + Attributes
        + user (required)
            + token_type: bearer (string, required)
            + access_token: eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzUxMiJ9.eyJ1dWlkIjoiNWIzOTg3NDEzZjUxMDA4ZTM1NjIzYzBjNjNkNGU4MWYwYTA5YjlhOWY3YTk2MjFiYWQ5MWJkMmNkZGExMWYxYTdhZWRkN2Q4Njc3MTBlZGIwMTgxMDZkN2VlYTFkM2NmMjFjZWNiZTVkMTU1YjIxOWU5YmViZDIzMTU2ODUwZjU4NjM2YWEyNTg2ZDMyNjhmNjdlOGYyNWI3NDgyMmJjZGE5YTBlNTAwNmZmNjUxNjA0OWYwOGQwZjk4MDdiMWE2YmY4NjM0NTM1ZTRiZWM0NTVmN2EzODdmOTZmODYwY2E1OGQ2YWU0ZDM0MjRlMjc0NDJhOTNmMjEwNzk2MzdkNyIsIm5hbWUiOiJyeXNraXQiLCJpc3MiOiJUb0RvIEFwcCIsInN1YiI6IlJlZnJlc2ggVG9rZW4iLCJleHAiOjE1MDQ2OTg5MjEsIm5nZiI6MTUwNDYxMjUxNiwiaWF0IjoxNTA0NjEyNTIxfQ.9ME9O34d6ft779H9vOJYE12eQL2ifL02TwmAmUkwfZShLqTBTFGEpL_wQztT9jKRaRZStjwtFLOLWQ_6swdbKg (string, required)
            + refresh_token: 61f00443c2228947d2e786b6e0b67311bb47e7ecf8926fc93477eeec8f942da9348395fced13d7f58a2c336ab594def5603e788d46974685f056e02a14b434930b3d4885b31e8ea15a5b03ecfa5995dc52fe575a4a7d86078d19455c258fdf1ee1a4bf92c4db4372d6f3ae5dc1e250ad12550cf84c4057ead4113fd27a8c4ec5 (string, required)
            + refresh_token_exp (number, required)

