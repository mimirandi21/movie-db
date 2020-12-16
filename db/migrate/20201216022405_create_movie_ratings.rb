class CreateMovieRatings < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_ratings do |t|
      t.bigint :movie_id
      t.bigint :rating_id

      t.timestamps
    end
  end
end
