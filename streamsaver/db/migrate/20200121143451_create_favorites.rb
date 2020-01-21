class CreateFavorites < ActiveRecord::Migration[6.0]
  def change
    create_table :favorites do |t|
      t.string :months
      t.integer :show_id
      t.integer :user_id
      t.boolean :watched

      t.timestamps
    end
  end
end
