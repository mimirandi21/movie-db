class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :user_movies do |t|
      t.integer :user_id
      t.integer :movie_id
      t.text :source
      t.integer :user_rating
      t.text :user_notes
      t.text :private_notes

      t.timestamps
    end
  end
end
