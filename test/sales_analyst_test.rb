require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'minitest/autorun'

class SalesAnalystTest < Minitest::Test
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

  def test_check_if_instance_of_a_method_exist
      assert_instance_of SalesAnalyst, @sa
  end

  def test_if_average_item_per_merchant_return_the_average
    # skip
    expected = 2.88

    assert_equal expected, @sa.average_items_per_merchant
  end

  def test_for_golden_items
    # skip
    expected = 5

    assert_equal expected, @sa.golden_items.length
  end

  def test_top_merchants_by_invoice_count
    expected = 12

    assert_equal expected, @sa.top_merchants_by_invoice_count.length
  end

  def test_bottom_merchant_by_invoice_count
    expected = 4

    assert_equal expected, @sa.bottom_merchants_by_invoice_count.length
  end

  def test_top_days_by_invoice_count
    expected = 1

    assert_equal expected, @sa.top_days_by_invoice_count.length
    assert_equal "Wednesday", @sa.top_days_by_invoice_count[0]
  end

  def test_invoice_status_returns_percentage
    expected = 29.55

    assert_equal expected, @sa.invoice_status(:pending)
    assert_equal 56.95, @sa.invoice_status(:shipped)
    assert_equal 13.5, @sa.invoice_status(:returned)
  end

end
