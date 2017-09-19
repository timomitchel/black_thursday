require "./lib/invoice_item_repository"
require './lib/sales_engine'
require 'minitest/autorun'

class InvoiceItemRepositoryTest < Minitest::Test
  attr_reader :repository

  def setup
    @se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = InvoiceItemRepository.new("./test/fixtures/truncated_invoice_items.csv" , @se)
  end

  def test_csv_loads_csv_file
    assert_instance_of CSV, repository.csv_load("./test/fixtures/truncated_invoice_items.csv")
  end

  def test_finds_all_data
    assert_equal repository.data, repository.all
  end

  def test_find_by_id_returns_correct_item_id
    assert_instance_of InvoiceItem, repository.find_by_id(2)
    assert_equal 263538156, repository.find_by_id(2).item_id
    assert_nil nil, repository.find_by_id('invalid id')
  end

  def test_find_all_by_item_id_returns_array_of_invoice_items
    assert_instance_of Array, repository.find_all_by_item_id(263538156)
    assert_equal 2, repository.find_all_by_item_id(263538156).length
    assert_equal [], repository.find_all_by_item_id(263538156230840)
  end

  def test_find_all_by_invoice_id_returns_array_of_invoice_items
    assert_instance_of Array, repository.find_all_by_invoice_id(6)
    assert_equal 7, repository.find_all_by_invoice_id(6).length
    assert_equal [], repository.find_all_by_invoice_id(0)
  end
end
