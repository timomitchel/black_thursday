require 'minitest/autorun'
require_relative "../lib/sales_engine"
require_relative "../lib/sales_analyst"

class MathTest < Minitest::Test

  def setup
    @se = SalesEngine.from_csv({
      :items => "./data/items.csv",
      :merchants => "./data/merchants.csv",
      :invoices => "./data/invoices.csv",
      :invoice_items => "./data/invoice_items.csv",
      :transactions => "./data/transactions.csv",
      :customers => "./data/customers.csv"
    })
    @sa = SalesAnalyst.new(@se)
  end

  def test_if_average_items_per_merchant_standard_deviation
    expected = 3.26

    assert_equal expected, @sa.average_items_per_merchant_standard_deviation
  end

  def test_if_merchants_with_high_item_count
    expected = 52

    assert_equal expected, @sa.merchants_with_high_item_count.length
  end

  def test_if_average_item_price_for_merchant
    expected = 16.66

    assert_equal expected, @sa.average_item_price_for_merchant(12334105)
  end

  def test_average_average_price_per_merchant
    expected = 350.29

    assert_equal expected, @sa.average_average_price_per_merchant
  end

  def test_average_invoices_per_merchant
    expected = 10.49

    assert_equal expected, @sa.average_invoices_per_merchant
  end

  def test_if_average_invoices_per_merchant_standard_deviation
    expected = 3.29

    assert_equal expected, @sa.average_invoices_per_merchant_standard_deviation
  end

end
