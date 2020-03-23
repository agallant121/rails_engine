class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      enable_extension "citext"
      t.citext :name
      t.citext :description
      t.integer :unit_price
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
