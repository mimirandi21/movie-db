class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.text :name
      t.text :plot
      t.text :summary
      t.bigint :length
      t.text :poster_url
      t.text :imdb_link
      t.timestamps
    end
  end
end
