class CreateMovieGenres < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_genres do |t|
      t.bigint :movie_id
      t.bigint :genre_id

      t.timestamps
    end
  end
end
