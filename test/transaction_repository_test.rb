require 'minitest/autorun'
require_relative "../lib/transaction_repository"
require_relative "../lib/sales_engine"

class TransactionRepositoryTest < Minitest::Test
  attr_reader :repository
  def setup
    se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = TransactionRepository.new("./test/fixtures/truncated_transactions.csv" , se)
  end

  def test_csv_loads_csv_file
    assert_equal CSV, repository.csv_load("./test/fixtures/truncated_transactions.csv").class
  end

  def test_if_class_item_repository_exist
    assert_instance_of TransactionRepository, repository
  end

  # def test_find_invoice_by_id_works
  #   assert_equal 3715, repository.find_invoice_by_transaction_id(5)
  # end

end
