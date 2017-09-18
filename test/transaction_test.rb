require 'minitest/autorun'
require_relative "../lib/transaction"
require_relative "../lib/transaction_repository"
require_relative "../lib/sales_engine"
require "pry"

class TransactionTest < Minitest::Test

  def setup
    @se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repo = TransactionRepository.new("./test/fixtures/truncated_transactions.csv", @se)
    @tran = Transaction.new({id: "1", invoice_id: '2179' ,credit_card_number: '4068631943231473', credit_card_expiration_date: '0217', result:'success',created_at: '2012-02-26 20:56:56 UTC', updated_at: '2012-02-26 20:56:56 UTC'}, @repo)
  end

  def test_transaction_class_can_instantiate
    assert_instance_of Transaction, @tran
  end

  def test_transactions_returns_correct_id
    assert_equal 1, @tran.id
  end

  def test_transaction_returns_correct_invoice_id
    assert_equal 2179, @tran.invoice_id
  end

  def test_transaction_returns_correct_cc_number
    assert_equal 4068631943231473, @tran.credit_card_number
  end

  def test_transaction_returns_correct_cc_expiration_date
    assert_equal '0217', @tran.credit_card_expiration_date
  end

  def test_tranasction_returns_correct_result
    assert_equal 'success', @tran.result
  end

  def test_transaction_returns_correct_created_at
    assert_equal DateTime.parse("2012-02-26 20:56:56 UTC").to_time, @tran.created_at
  end

  def test_transaction_returns_correct_updated_at
    assert_equal DateTime.parse("2012-02-26 20:56:56 UTC").to_time, @tran.updated_at
  end

  def test_that_parent_works
    assert_equal @repo, @tran.parent
  end

  def test_invoice_returns_an_invoice
    assert_instance_of Invoice, @tran.invoice
  end

end
