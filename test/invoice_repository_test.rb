require "./lib/invoice_repository"
require './lib/sales_engine'
require 'minitest/autorun'

class InvoiceRepositoryTest < Minitest::Test
  attr_reader :repository

  def setup
    se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = InvoiceRepository.new("./test/fixtures/truncated_invoices.csv" , se)
  end

  def test_csv_loads_csv_file
    assert_equal CSV, repository.csv_load("./test/fixtures/truncated_invoices.csv").class
  end

  def test_all_returns_data
    assert_equal repository.data ,repository.all
  end

  def test_find_by_id_returns_invoice
    assert_equal Invoice, repository.find_by_id(1).class
  end

  def test_find_all_by_customer_id_returns_array
    assert_equal Array, repository.find_all_by_customer_id(1).class
    assert_equal Invoice, repository.find_all_by_customer_id(1).first.class
  end

  def test_

  end

end
