require 'minitest/autorun'
require_relative "../lib/invoice_item"
require_relative "../lib/invoice_item_repository"
require_relative "../lib/sales_engine"
require_relative 'test_helper'

class InvoiceItemTest < Minitest::Test
attr_reader :invoice_item

  def setup
    @se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = InvoiceItemRepository.new("./test/fixtures/truncated_items.csv" , @se)
    @invoice_item = InvoiceItem.new({id: "1", item_id: "263519844", invoice_id: "1", quantity: "5", unit_price: "13635", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC"}, @repository)
  end

  def test_if_class_exist
    assert_instance_of InvoiceItem, invoice_item
  end

  def test_it_returns_correct_attributes
    assert_equal 1, @invoice_item.id
    assert_equal 263519844, @invoice_item.item_id
    assert_equal 1, @invoice_item.invoice_id
    assert_equal 5, @invoice_item.quantity
    assert_equal 0.13635e3, @invoice_item.unit_price
    assert_equal 27, @invoice_item.created_at.day
    assert_equal 3, @invoice_item.created_at.month
    assert_equal 2012, @invoice_item.updated_at.year
    assert_equal 3, @invoice_item.updated_at.month
  end

  def test_unit_price_to_dollars_returns_dollar_amount
    assert_equal 136.35, @invoice_item.unit_price_to_dollars
  end

  def test_price_returns_correct_price
    assert_instance_of BigDecimal, @invoice_item.price
    assert_equal 0.68175e3, @invoice_item.price
  end

end
