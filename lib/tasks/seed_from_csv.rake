require 'csv'

namespace :seed_from_csv do
  desc "clear and use csv data."
  task import: :environment do
    Customer.destroy_all
    Merchant.destroy_all
    Item.destroy_all
    Invoice.destroy_all
    InvoiceItem.destroy_all
    Transaction.destroy_all

    CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      Merchant.create(row.to_h)
    end

    CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      Item.create(row.to_h)
    end

    CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      Customer.create(row.to_h)
    end

    CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      Invoice.create(row.to_h)
    end

    CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      InvoiceItem.create(row.to_h)
    end

    CSV.foreach('./db/data/transactions.csv', headers: true, header_converters: :symbol, converters: :date_time) do |row|
      Transaction.create(row.to_h)
    end
  end
end
