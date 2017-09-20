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

  def test_average_invoices_per_merchant
    expected = 10.49

    assert_equal expected, @sa.average_invoices_per_merchant
  end

  def test_if_average_invoices_per_merchant_standard_deviation
    expected = 3.29

    assert_equal expected, @sa.average_invoices_per_merchant_standard_deviation
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

  def test_total_revenue_by_date
    date = Time.parse("2009-02-07")
    expected = 21067.77

    assert_equal expected , @sa.total_revenue_by_date(date)
  end

  def test_top_revenue_earners
    assert_equal 10, @sa.top_revenue_earners(10).count
    assert_equal 20, @sa.top_revenue_earners.count
    assert_equal Merchant, @sa.top_revenue_earners.first.class
  end

  def test_merchants_with_pending_invoices_return_array
    assert_equal 467, @sa.merchants_with_pending_invoices.length
  end

  def test_merchants_with_only_one_item
    assert_equal 243,@sa.merchants_with_only_one_item.length
  end

  def test_merchants_with_only_one_item_registered_in_month_return_array
    assert_equal 18, @sa.merchants_with_only_one_item_registered_in_month("June").length
  end

  def test_revenue_by_merchant_return_the_total_revenue
    assert_equal 0.7342608e5, @sa.revenue_by_merchant(12334113)
  end

  def test_most_sold_item_for_merchant_returns_array_or_single_item
    assert_equal 263524984, @sa.most_sold_item_for_merchant(12334189).first.id
  end

  def test_best_item_for_merchant_returns_most_profitable_item
    assert_equal 263516130, @sa.best_item_for_merchant(12334189).id
  end

end
