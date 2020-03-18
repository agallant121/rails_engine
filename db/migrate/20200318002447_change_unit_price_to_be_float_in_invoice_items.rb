class ChangeUnitPriceToBeFloatInInvoiceItems < ActiveRecord::Migration[6.0]
  def change
    change_column :invoice_items, :unit_price, :float
  end
end
