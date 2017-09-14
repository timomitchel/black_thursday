require_relative "../lib/invoice_repository"
require_relative '../lib/sales_engine'
require 'csv'
require 'minitest/autorun'

class InvoiceRepositoryTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({:invoices => "../data/fixtures/truncated/invoices.csv"})

  end

  def test_can_find_invoice_by_id
    invoice = @se.invoices.find_by_id(6)
    invoice_nil = @se.invoices.find_by_id()

    assert_equal nil, invoice_nil

    assert_equal 2, invoice

  end

  def test_can_find_invoice_by_customer_id
    invoice = @se.invoices.find_by_customerid()
    invoice_nil = @se.invoices.find_by_customerid()

    assert_equal nil, invoice_nil
    assert_equal 2, invoice

  end

  def test_can_find_invoice_by_merchant_id
    invoice = @se.invoices.find_by_merchant_id()
    invoice_empty_array = @se.invoices.find_by_merchant_id()

    assert_equal nil, invoice_empty_array
    assert_equal 2, invoice

  end

  def test_can_find_all_invoices
    invoice = @se.invoices.all

    assert_equal [], invoice

  end

  def test_can_find_invoice_by_status
    invoice = @se.invoices.find_all_by_status()
    invoice_empty = @se.invoices.find_all_by_status()

    assert_equal [], invoice_empty
    assert_equal 's', invoice

  end



end
