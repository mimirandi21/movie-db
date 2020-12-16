class CreateMovieScores < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_scores do |t|
      t.bigint :movie_id
      t.bigint :score_id
      t.text :source

      t.timestamps
    end
  end
end
