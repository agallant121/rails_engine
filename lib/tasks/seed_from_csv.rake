require 'csv'

namespace :seed_from_csv do
  desc "destroy and import csv data"
  task import: :environment do
    data_sets = [Customer, Merchant, Item, Invoice, InvoiceItem, Transaction]
    data_sets.each do |set|
      set.destroy_all
    end

    puts "Importing Merchants"

    CSV.foreach('./db/data/merchants.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      Merchant.create(row.to_h)
    end

    puts "Importing Items"


    CSV.foreach('./db/data/items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      Item.create(row.to_h)
    end

    puts "Importing Customers"

    CSV.foreach('./db/data/customers.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      Customer.create(row.to_h)
    end

    puts "Importing Invoices"

    CSV.foreach('./db/data/invoices.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      Invoice.create(row.to_h)
    end

    puts "Importing InvoiceItems"

    CSV.foreach('./db/data/invoice_items.csv', headers: true, header_converters: :symbol, converters: :all) do |row|
      InvoiceItem.create(row.to_h)
    end

    puts "Importing Transactions"

    CSV.foreach('./db/data/transactions.csv', headers: true, header_converters: :symbol, converters: :date_time) do |row|
      Transaction.create(row.to_h)
    end
  end
end
