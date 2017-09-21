require_relative '../lib/sales_analyst'
require_relative '../lib/sales_engine'
require 'minitest/autorun'
require_relative 'test_helper'

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
    expected = 2.88

    assert_equal expected, @sa.average_items_per_merchant
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

  def test_for_golden_items
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
