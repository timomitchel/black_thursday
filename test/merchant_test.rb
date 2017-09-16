require 'minitest/autorun'
require_relative "../lib/merchant"

class MerchantTest < Minitest::Test
  def test_can_instantiate_merchant_class
    merchant = Merchant.new({name: "Miguel", id: "123",
    created_at: "today",
    updated_at: "tomorrow"})

    assert_instance_of Merchant, merchant
  end

  def test_name_points_at_value
      merchant = Merchant.new({name: "Miguel", id: "123",
      created_at: "today",
      updated_at: "tomorrow"})

      assert_equal "Miguel", merchant.name

  end

  def test_id_points_at_value
      merchant = Merchant.new({name: "Miguel", id: "123",
      created_at: "today",
      updated_at: "tomorrow"})

      assert_equal "123", merchant.id
  end

  def test_created_at_points_at_value
      merchant = Merchant.new({name: "Miguel", id: "123",
      created_at: "today",
      updated_at: "tomorrow"})

      assert_equal "today", merchant.created_at
  end

  def test_updated_at_points_at_value
      merchant = Merchant.new({name: "Miguel", id: "123",
      created_at: "today",
      updated_at: "tomorrow"})

      assert_equal "tomorrow", merchant.updated_at
  end

end
