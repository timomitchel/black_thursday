require_relative 'invoice'
require 'csv'

class InvoiceRepository
  attr_reader :data, :parent

  def initialize(data, parent)
    @data = csv_load(data).map {|row| Invoice.new(row, self)}
    @parent = parent
  end

  def csv_load(file_path)
   CSV.open file_path, headers: true, header_converters: :symbol
  end

  def all
    @data
  end

  def find_invoice_item_by_invoice_id(id)
    parent.find_invoice_item_by_invoice_id(id)
  end

  def find_transaction_by_invoice_id(id)
    parent.find_transaction_by_invoice_id(id)
  end

  def find_customer_by_invoice_id(id)
    parent.find_customer_by_invoice_id(id)
  end

  def find_item_by_invoice_id(id)
    parent.find_item_by_invoice_id(id)
  end

  def find_merchant_by_invoice(merchant)
    parent.find_merchant_by_invoice(merchant)
  end

  def find_by_id(invoice_id)
    data.find {|invoice|invoice.id.to_i == invoice_id}
  end

  def find_all_by_customer_id(customer)
    data.select {|invoice| invoice.customer_id.to_i == customer}
  end

  def find_all_by_merchant_id(merchant)
    data.select {|invoice| invoice.merchant_id.to_i == merchant}
  end

  def find_all_by_status(stats)
    data.select {|invoice| invoice.status == stats}
  end

  def inspect
     "#{self.class}"
  end

end
