require 'minitest/autorun'
require_relative "../lib/merchant"
require_relative "../lib/merchant_repository"
require_relative "../lib/sales_engine"

class MerchantTest < Minitest::Test
  
  def setup
    @se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    @repository = MerchantRepository.new("./test/fixtures/truncated_merchants.csv" , @se)
    @mer = Merchant.new({id: "12341234", name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)
  end

  def test_can_instantiate_merchant_class
    assert_instance_of Merchant, @mer
  end

  def test_name_points_at_value
      assert_equal "Shopin1901", @mer.name

  end

  def test_id_points_at_value
      assert_equal 12341234, @mer.id
  end

  def test_created_at_points_at_value
      assert_equal 12, @mer.created_at.month
  end

  def test_updated_at_points_at_value
      assert_equal 12, @mer.updated_at.month
  end

  def test_if_parents_work
    assert_equal @repository, @mer.parent
  end

  def test_items_return_item
    assert_equal Item, @mer.items.first.class
    assert_equal 123456789, @mer.items.first.id
  end

  def test_invoices_return_invoice
    mer = Merchant.new({id: "12335009", name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)

    assert_equal Invoice, mer.invoices.first.class
    assert_equal 7, mer.invoices.first.id
  end

  def test_customers_return_customer
    mer = Merchant.new({id: "12335009", name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)

    assert_equal Invoice, mer.invoices.first.class
    assert_equal 7, mer.invoices.first.id
  end

  def test_revenue_returns_revenue
    mer = Merchant.new({id: "12336225", name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)

    assert_equal 0, mer.revenue
  end

  def test_has_pending_invoices_return_array
    mer = Merchant.new({id: "12336225", name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)

    assert_equal true, mer.has_pending_invoices?
  end

  def test_has_one_item
    mer = Merchant.new({id: "623456789", name: "Shopin1901", created_at: "2010-12-10", updated_at: "2011-12-04"}, @repository)

    assert_equal false, mer.has_one_item?
  end
end
