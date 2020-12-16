class CreateActors < ActiveRecord::Migration[6.0]
  def change
    create_table :actors do |t|
      t.text :name
      t.text :imdb_link
      t.text :img_url
      t.timestamps
    end
  end
end
