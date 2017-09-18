require 'minitest/autorun'
require_relative "../lib/customer"
require_relative "../lib/customer_repository"
require_relative "../lib/sales_engine"

class CustomerRepositoryTest < Minitest::Test
  attr_reader :repository

  def setup
    @se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
      :merchants => "./test/fixtures/truncated_merchants.csv",
      :invoices => "./test/fixtures/truncated_invoices.csv",
      :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
      :transactions => "./test/fixtures/truncated_customers.csv",
      :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = CustomerRepository.new("./test/fixtures/truncated_customers.csv" , @se)
  end

  def test_csv_loads_csv_file
    assert_equal CSV, repository.csv_load("./test/fixtures/truncated_customers.csv").class
  end

  def test_all_returns_data
    assert_equal repository.data, repository.all
  end

  def test_parent_returns_sales_engine
    assert_equal @se, repository.parent
  end

end
