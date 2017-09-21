require 'minitest/autorun'
require_relative "../lib/merchant_repository"
require_relative "../lib/sales_engine"
require_relative 'test_helper'

class MerchantRepositoryTest < Minitest::Test
  attr_reader :repository
  def setup
    se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = MerchantRepository.new("./test/fixtures/truncated_merchants.csv" , se)
  end

  def test_csv_loads_csv_file
    assert_equal CSV, repository.csv_load("./test/fixtures/truncated_merchants.csv").class
  end

  def test_if_class_item_repository_exist
    assert_instance_of MerchantRepository, repository
  end

  def test_if_find_by_name_works
    assert_equal Merchant, repository.find_by_name("Shopin1901").class
    assert_equal 12334105, repository.find_by_name("Shopin1901").id
    assert_nil nil, repository.find_by_name("12")
  end

  def test_find_by_id_works
    assert_equal Merchant, repository.find_by_id(12334105).class
    assert_equal "Shopin1901", repository.find_by_id(12334105).name
    assert_nil nil, repository.find_by_id(12)
  end

  def test_all_returns_all_instances
    assert_equal 59, repository.all.count
  end

  def test_find_all_by_name_returns_array
    assert_equal Merchant, repository.find_all_by_name("S").first.class
    assert_equal "Shopin1901", repository.find_all_by_name("S").first.name
    assert_equal 36, repository.find_all_by_name("S").count
    assert_nil nil, repository.find_all_by_name("Z")
  end

  def test_find_customer_by_merchant_id_return_customer
    assert_equal Customer, repository.find_customer_by_merchant_id(12334112).first.class
    assert_equal 5, repository.find_customer_by_merchant_id(12334112).first.id
  end

  def test_find_items_by_merchant_return_items
    assert_equal Item, repository.find_items_by_merchant(12334112).first.class
    assert_equal 1, repository.find_items_by_merchant(12334112).count
  end

  def test_find_invoices_by_merchant_return_invoices
    assert_equal Invoice, repository.find_invoices_by_merchant(12334112).first.class
    assert_equal 1, repository.find_invoices_by_merchant(12334112).count
  end

  def test_inspect_method_works
    assert_equal "MerchantRepository", repository.inspect
  end
end
