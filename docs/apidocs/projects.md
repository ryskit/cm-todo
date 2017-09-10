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
