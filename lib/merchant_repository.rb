require_relative "merchant"
require 'csv'
require 'pry'

class MerchantRepository
  attr_reader :data, :parent

  def initialize(data, parent)
    @data = csv_load(data).map {|row| Merchant.new(row, self)}
    @parent = parent
  end

  def find_customer_by_merchant_id(id)
    parent.find_customer_by_merchant_id(id)
  end

  def csv_load(file_path)
   CSV.open file_path, headers: true, header_converters: :symbol
  end

  def find_items_by_merchant(id)
    parent.find_items_by_merchant(id)
  end

  def find_invoices_by_merchant(id)
    parent.find_invoices_by_merchant(id)
  end

  def find_by_name(merchant)
    data.find {|object| object.name.downcase == merchant.downcase}
  end

  def all
    @data
  end

  def find_by_id(merchant)
    data.find {|object| object.id == merchant}
  end

  def find_all_by_name(merchant)
    data.select {|object| object.name.downcase.include?(merchant.downcase)}
  end

  def inspect
     "#{self.class}"
  end

end
