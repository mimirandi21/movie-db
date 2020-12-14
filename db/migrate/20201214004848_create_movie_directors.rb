class CreateMovieDirectors < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_directors do |t|
      t.bigint :movie_id
      t.bigint :director_id

      t.timestamps
    end
  end
end
