class ChangeUnitPriceToBeFloatInItemss < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :unit_price, :float
  end
end
