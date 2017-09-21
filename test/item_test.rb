require 'minitest/autorun'
require_relative "../lib/item"
require_relative "../lib/item_repository"
require_relative "../lib/sales_engine"

class ItemTest < Minitest::Test
  
  attr_reader :item

  def setup
    @se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = ItemRepository.new("./test/fixtures/truncated_items.csv" , @se)
    @item = Item.new({id: "123456789", name: "Christmas Sweaters", description: "Ugly sweaters for everyone", unit_price: "12111", merchant_id: "12334319", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)
  end

  def test_if_class_exist
    assert_instance_of Item, item
  end

  def test_if_id_returns_item_id
    actual = Item.new({id: "223456789", name: "Christmas Sweaters", description: "Ugly sweaters for everyone", unit_price: "12111", merchant_id: "12341234", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)

    assert_equal 123456789, item.id
    assert_nil nil, actual
  end

  def test_if_name_returns_name
    actual = Item.new({id: "223456789", name: "Christmas Sweets", description: "Ugly sweaters for everyone", unit_price: "12111", merchant_id: "12341234", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)

    assert_equal "Christmas Sweaters", item.name
    assert_nil nil, actual
  end

  def test_if_description_returns_string
    actual = Item.new({id: "223456789", name: "Christmas Sweets", description: "Ugly sweets for everyone", unit_price: "12111", merchant_id: "12341234", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)

    assert_equal "Ugly sweaters for everyone", item.description
    assert_nil nil, actual
  end

  def test_unit_price
    assert_equal BigDecimal, item.unit_price.class
    assert_equal 0.12111e3, item.unit_price
  end

  def test_created_at_returns_time_class
    assert_equal Time, item.created_at.class
    assert_equal 12, item.created_at.month
    assert_equal 10, item.created_at.day
  end

  def test_updated_at_returns_time_class
    assert_equal Time, item.updated_at.class
    assert_equal 12, item.updated_at.month
    assert_equal 4, item.updated_at.day
  end

  def test_merchant_id_returns_id
    assert_equal 12334319, item.merchant_id
  end

  def test_for_parent_method_returns_item_repo
    assert_instance_of ItemRepository, item.parent
  end

  def test_merchant_returns_merchant_class
    assert_equal Merchant, item.merchant.class
  end

  def test_unit_price_returns_float
    assert_equal Float, item.unit_price_to_dollars.class
    assert_equal 121.11, item.unit_price_to_dollars
  end

end
