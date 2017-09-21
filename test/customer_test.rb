require 'minitest/autorun'
require_relative "../lib/customer"
require_relative "../lib/customer_repository"
require_relative "../lib/sales_engine"
require_relative 'test_helper'

class CustomerTest < Minitest::Test
  
  attr_reader :customer

  def setup
    @se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = CustomerRepository.new("./test/fixtures/truncated_customers.csv" , @se)
    @customer = Customer.new({id: 1, first_name: "Joey", last_name: "Ondricka", created_at: "2012-03-27 14:54:09 UTC", updated_at: "2012-03-27 14:54:09 UTC" }, @repository)
  end

  def test_if_customer_returns_id
    assert_equal 1, customer.id
  end

  def test_if_customer_returns_first_name
    assert_equal "Joey", customer.first_name
  end

  def test_if_customer_returns_last_name
    assert_equal "Ondricka", customer.last_name
  end

  def test_if_customer_returns_created_at
    assert_equal "2012-03-27 14:54:09 UTC", customer.created_at.to_s
  end

  def test_if_returns_customer_returns_id
    assert_equal "2012-03-27 14:54:09 UTC", customer.updated_at.to_s
  end
end
