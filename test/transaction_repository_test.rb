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

  def test_find_invoice_by_id_works
    assert_equal Invoice, repository.find_invoice_by_transaction_id(5).class
    assert_equal 1, repository.find_invoice_by_transaction_id(5).customer_id
    assert_nil nil, repository.find_invoice_by_transaction_id(9324832948)
  end

  def test_find_by_id_works
    assert_equal Transaction, repository.find_by_id(4).class
    assert_equal 4126, repository.find_by_id(4).invoice_id
    assert_nil nil, repository.find_by_id('s')
  end

  def test_find_all_by_invoice_id_works_and_returns_array
    assert_equal Array, repository.find_all_by_invoice_id(2179).class
    assert_equal 1, repository.find_all_by_invoice_id(2179).length
    assert_equal [], repository.find_all_by_invoice_id('t')
  end

  def test_find_all_by_credit_card_number_works_and_returns_array
    assert_equal Array, repository.find_all_by_credit_card_number(4068631943231473).class
    assert_equal 1, repository.find_all_by_credit_card_number(4068631943231473).length
    assert_equal [], repository.find_all_by_credit_card_number('2048t832080302')
  end

  def test_find_all_by_result_returns_array_and_all_with_matching_status
    assert_equal Array, repository.find_all_by_result('failed').class
    assert_equal 22, repository.find_all_by_result('failed').length
    assert_equal [], repository.find_all_by_result(23)
  end

end
