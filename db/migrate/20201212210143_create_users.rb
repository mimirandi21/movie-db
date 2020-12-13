class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :password_digest
      t.uuid :uid
      t.text :google_token
      t.text :google_refresh_token

      t.timestamps
    end
  end
end
