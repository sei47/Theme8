class AddColumnsToPictures < ActiveRecord::Migration[6.0]
  def change
    add_reference :pictures, :user, foreign_key: true
    add_column :users, :profile, :text
  end
end
