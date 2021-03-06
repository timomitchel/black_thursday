require 'time'

class Invoice
  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @customer_id = data[:customer_id].to_i
    @merchant_id = data[:merchant_id].to_i
    @status = data[:status].to_sym
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @parent = parent
  end

  def merchant
    parent.find_merchant_by_invoice(merchant_id)
  end

  def items
    parent.find_item_by_invoice_id(id)
  end

  def transactions
    parent.find_transaction_by_invoice_id(id)
  end

  def customer
    parent.find_customer_by_invoice_id(customer_id)
  end

  def is_paid_in_full?
    !transactions.empty? && transactions.any? do |transaction|
      transaction.result == "success"
    end
  end

  def invoice_items
    parent.find_invoice_item_by_invoice_id(id)
  end

  def total
    invoice_items.reduce(0) do |unit, invoice_item|
      unit += is_paid_in_full? ? invoice_item.price : 0
    end
  end

end
