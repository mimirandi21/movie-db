class CreateMovies < ActiveRecord::Migration[6.0]
  def change
    create_table :movies do |t|
      t.text :name
      t.bigint :year
      t.text :genre
      t.text :plot
      t.text :summary
      t.text :rating
      t.float :score
      t.bigint :length
      t.text :poster_url
      t.bigint :director_id
      
      t.timestamps
    end
  end
end
