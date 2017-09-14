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

  def find_merchant_by_invoice(merchant)
    parent.find_merchant_by_invoice(merchant)
  end

  def find_by_id(invoice_id)
    data.find do |invoice|
      invoice.id.to_i == invoice_id
    end
  end

  def find_all_by_customer_id(customer)
    data.select do |invoice|
      invoice.customer_id.to_i == customer
    end
  end

  def find_all_by_merchant_id(merchant)
    data.select do |invoice|
      invoice.merchant_id.to_i == merchant
    end
  end

  def find_all_by_status(stats)
    data.select do |invoice|
      invoice.status == stats
    end
  end

  def inspect
     "#{self.class}"
  end

end
