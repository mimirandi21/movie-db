class CreateMovieWriters < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_writers do |t|
      t.bigint :movie_id
      t.bigint :writer_id

      t.timestamps
    end
  end
end
