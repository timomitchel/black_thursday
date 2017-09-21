require 'minitest/autorun'
require_relative "../lib/sales_engine"
require_relative "../lib/sales_analyst"

class MerchantAnalystTest < Minitest::Test
  
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

  def test_merchants_ranked_by_revenue
    assert_equal 12334634, @sa.merchants_ranked_by_revenue.first.id
    assert_equal 12336175, @sa.merchants_ranked_by_revenue.last.id
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
