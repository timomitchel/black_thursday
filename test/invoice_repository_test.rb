require_relative "../lib/invoice_repository"
require_relative '../lib/sales_engine'
require_relative '../lib/invoice'
require 'minitest/autorun'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = InvoiceRepository.new("./test/fixtures/truncated_merchants.csv" , se)
  end

  def test_csv_loads_csv_file
    assert_equal CSV, @repository.csv_load("./test/fixtures/truncated_invoices.csv").class
  end

end
