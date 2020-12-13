class CreateMovieActors < ActiveRecord::Migration[6.0]
  def change
    create_table :movie_actors do |t|
      t.bigint :movie_id
      t.bigint :actor_id
      t.text :role

      t.timestamps
    end
  end
end
