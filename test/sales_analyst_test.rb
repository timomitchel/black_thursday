require './lib/sales_analyst'
require './lib/sales_engine'
require 'minitest/autorun'

class SalesAnalystTest < Minitest::Test
  def setup
    se = SalesEngine.from_csv({:items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"})
    @sa = SalesAnalyst.new(se)
  end

  def test_check_if_instance_of_a_method_exist
    se = SalesEngine.from_csv({:items     => "./data/items.csv",
                              :merchants => "./data/merchants.csv"})
    sa = SalesAnalyst.new(se)
    assert_instance_of SalesAnalyst, sa
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

    assert_equal expected, @sa.merchants_with_high_item_count
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

    assert_equal expected, @sa.golden_items
  end
end
