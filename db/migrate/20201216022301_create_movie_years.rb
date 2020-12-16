class CreateMovieYears < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_years do |t|
      t.bigint :movie_id
      t.bigint :year_id

      t.timestamps
    end
  end
end
