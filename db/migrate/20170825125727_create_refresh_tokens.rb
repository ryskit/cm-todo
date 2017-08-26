class CreateRefreshTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :refresh_tokens do |t|
      t.string :token, unique: true
      t.integer :expiration
      t.references :user, foreign_key: true
      
      t.timestamps
    end
  end
end
