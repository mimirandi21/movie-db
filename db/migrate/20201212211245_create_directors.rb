class CreateDirectors < ActiveRecord::Migration[6.0]
  def change
    create_table :directors do |t|
      t.text :name
      t.text :imdb_link

      t.timestamps
    end
  end
end
