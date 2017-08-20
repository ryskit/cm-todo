class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.bigint :user_id
      t.string :title
      t.text :content
      t.timestamp :due_to

      t.timestamps
    end
  end
end
