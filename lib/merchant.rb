require 'time'
class Merchant

  attr_reader :name, :id, :created_at, :updated_at, :parent

  def initialize(data, parent)
     @name = data[:name]
     @id = data[:id].to_i
     @created_at = Time.parse(data[:created_at])
     @updated_at = Time.parse(data[:updated_at])
     @parent = parent
  end

  def items
    parent.find_items_by_merchant(id)
  end

  def invoices
    parent.find_invoices_by_merchant(id)
  end

  def customers
    parent.find_customer_by_merchant_id(id)
  end
end
