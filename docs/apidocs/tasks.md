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
