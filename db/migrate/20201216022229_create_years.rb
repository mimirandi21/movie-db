class CreateYears < ActiveRecord::Migration[6.0]
  def change
    create_table :years do |t|
      t.bigint :year

      t.timestamps
    end
  end
end
