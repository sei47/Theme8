class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.references :users, foreign_key: true
      t.references :pictures, foreign_key: true

      t.timestamps
    end
  end
end
