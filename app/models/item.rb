class Item < ApplicationRecord
  validates_presence_of :name, :unit_price, :description

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  # has_many :transactions, through: :invoices
end
