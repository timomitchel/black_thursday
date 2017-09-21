require 'minitest/autorun'
require_relative "../lib/sales_engine"
require_relative 'test_helper'

class SalesEngineTest < Minitest::Test

  def setup
    @so = SalesEngine.from_csv({
      :items     => "./test/fixtures/truncated_items.csv",
      :merchants => "./test/fixtures/truncated_merchants.csv",
      :invoices => "./test/fixtures/truncated_invoices.csv",
      :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
      :transactions => "./test/fixtures/truncated_transactions.csv",
      :customers => "./test/fixtures/truncated_customers.csv"
    })
  end

  def test_can_instantiate_sales_engine_class
    assert_instance_of SalesEngine, @so
  end


  def test_instance_of_the_class_item_repository
    assert_instance_of ItemRepository, @so.items
  end

  def test_if_find_items_by_merchant_works
    assert_equal Item, @so.find_items_by_merchant(12341234).first.class
  end

  def test_instance_of_the_class_merchant_repository
    assert_instance_of MerchantRepository, @so.merchants
  end

  def test_merchants_find_by_name_works
    mr = @so.merchants
    merchant = mr.find_by_name("CJsDecor")

    assert_equal merchant, mr.find_by_name("CJsDecor")
  end

  def test_instance_of_the_class_invoice_repository
    assert_instance_of InvoiceRepository, @so.invoices
  end

  def test_find_invoices_by_merchant_works
    assert_equal Invoice, @so.find_invoices_by_merchant(12335938).first.class
  end

  def test_instance_of_the_class_invoice_items_repository
    assert_instance_of InvoiceItemRepository, @so.invoice_items
  end

  def test_find_merchant_by_invoice_works
    assert_equal Merchant, @so.find_merchant_by_invoice(12334105).class
  end

  def test_find_item_by_invoice_id_works
    assert_equal Item, @so.find_item_by_invoice_id(1).compact.first.class
  end

  def test_instance_of_the_class_customer_repository
    assert_instance_of CustomerRepository, @so.customers
  end

  def test_instance_of_the_class_transaction_repository
    assert_instance_of TransactionRepository, @so.transactions
  end

  def test_find_transaction_by_invoice_id_works
    assert_equal Transaction, @so.find_transaction_by_invoice_id(2179).first.class
  end

  def test_find_customer_by_invoice_id_works
    assert_equal Customer, @so.find_customer_by_invoice_id(1).class
  end

  def test_find_invoice_by_transaction_id_works
    assert_equal Invoice, @so.find_invoice_by_transaction_id(1).class
  end

  def test_find_invoice_item_by_invoice_id_works
    assert_equal InvoiceItem, @so.find_invoice_item_by_invoice_id(1).first.class
  end

end
