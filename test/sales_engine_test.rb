require 'minitest/autorun'
require_relative "../lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv"
    })

    @so = SalesEngine.from_csv({
      :items     => "./test/fixtures/truncated_items.csv",
      :merchants => "./test/fixtures/truncated_merchants.csv",
      :invoices => "./test/fixtures/truncated_invoices.csv",
      :invoice_items => "./test/fixtures/truncated_invoice_items.csv"})
  end

  def test_can_instantiate_sales_engine_class
    assert_instance_of SalesEngine, @se
  end

  def test_from_csv_points_at_csv_file
    mr = @se.merchants
    merchant = mr.find_by_name("CJsDecor")

    assert_equal merchant, mr.find_by_name("CJsDecor")
  end

  def test_case_name
    mr = @so.merchants
    merchant = mr.find_by_name("CJsDecor")

    assert_equal merchant, mr.find_by_name("CJsDecor")
  end
end
