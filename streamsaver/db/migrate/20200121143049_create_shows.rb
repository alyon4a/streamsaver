class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.string :name
      t.string :description
      t.string :image_url
      t.integer :provider_id

      t.timestamps
    end
  end
end
