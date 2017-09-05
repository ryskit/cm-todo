## タスク情報取得 [/v1/tasks{?q, titel, content, checked, next_days}]

### タスク一覧情報取得API [GET]

#### 処理概要

* 条件で絞り込まれた複数のタスクを取得する。
* 自ユーザーが登録したタスクのみ取得できる。

+ Parameters

    + q: title_keyword (string, optional) - タスクのタイトル・コンテンツから部分一致するタスクを絞り込む
    + title: keyword (string, optional) - タスクのタイトルに含まれるかどうか
    + content: keyword (string, optional) - タスクのコンテンツに含まれるかどうか
    + checked: keyword (boolean, optional) - タスクが済みかどうか
    + next_days: day (number, optional) - タスクの期限が設定されており、期日が何日後以内のタスクを絞り込む
    + expired: day (boolean, optional) - タスクの有効期限が過ぎているかどうかで絞り込む

+ Response 200 (application/json)

    tasks: {
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
            "title": "update 2",
            "content": "content2",
            "due_to": null,
            "created_at": "2017-08-27T19:45:52.968+09:00",
            "updated_at": "2017-09-04T22:17:23.692+09:00",
            "user_id": 1,
            "checked": false
        }, ...
    }

