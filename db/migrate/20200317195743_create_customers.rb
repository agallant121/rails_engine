class CreateCustomers < ActiveRecord::Migration[6.0]
  def change
    create_table :customers do |t|
      enable_extension "citext"
      t.citext :first_name
      t.citext :last_name

      t.timestamps
    end
  end
end
