class CreateRefreshTokens < ActiveRecord::Migration[5.1]
  def change
    create_table :refresh_tokens do |t|
      t.string :token, unique: true
      t.references :user, foreign_key: true
      t.timestamp :expiration_at
      
      t.timestamps
    end
  end
end
