require 'minitest/autorun'
require "minitest/pride"
require "./lib/sales_engine"

class SalesEngineTest < Minitest::Test

  def test_can_instantiate_sales_engine_class
    se = SalesEngine.new('hello')

    assert_instance_of SalesEngine, se
  end

  def test_from_csv_points_at_csv_file
    se = SalesEngine.from_csv({
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    })
    mr = se.merchants
    merchant = mr.find_by_name("CJsDecor")

    assert_equal merchant, mr.find_by_name("CJsDecor")
  end



end
