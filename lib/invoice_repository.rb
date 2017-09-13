require './lib/invoice'
require 'pry'
class InvoiceRepository
attr_reader :data, :parent
  def initialize(data, parent)
    @data = data.map{|line| Invoice.new(line, self)}
    @parent = parent
  end

  def all
    @data
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

end
