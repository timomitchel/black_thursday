require './lib/item_repository'
require 'minitest/autorun'
require './lib/sales_engine'

class ItemRepositoryTest < Minitest::Test
  attr_reader :repository
  def setup
    @repository = ItemRepository.new("./test/fixtures/truncated_items.csv" , self)
  end

  def test_csv_loads_csv_file
    assert_equal CSV, repository.csv_load("./test/fixtures/truncated_items.csv").class
  end

  def test_if_class_item_repository_exist
    assert_instance_of ItemRepository, repository
  end

  def test_if_find_by_name_works
    expected = repository.find_by_name("Intricate Sunset")

    assert_equal expected, repository.find_by_name("Intricate Sunset")
  end

  def test_find_by_id_works
    assert_equal Item, repository.find_by_id(123456789).class
    assert_equal "Christmas Sweaters", repository.find_by_id(123456789).name
  end

  def test_all_if_returns_all_instances
    assert_equal 12, repository.all.count
  end

  def test_find_all_with_description_returns_description
    assert_equal Item, repository.find_all_with_description("Ugly necklaces for everyone").first.class
    assert_equal "Christmas necklaces", repository.find_all_with_description("Ugly necklaces for everyone").first.name
  end

  def test_find_all_by_price_returns_item
    assert_equal Item, repository.find_all_by_price(420.00).first.class
    assert_equal "Christmas skirts", repository.find_all_by_price(420.00).first.name
  end

  def test_find_all_by_price_range_return_array
    assert_equal Item, repository.find_all_by_price_in_range((130..140)).first.class
    assert_equal 2, repository.find_all_by_price_in_range((130..140)).count
  end

  def test_find_all_by_merchant_id_return_item
    assert_equal Item, repository.find_all_by_merchant_id(12341234).first.class
    assert_equal 7, repository.find_all_by_merchant_id(12341234).count
  end

  def test_if_parent_method_works
    se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    rep = ItemRepository.new("./test/fixtures/truncated_items.csv" , se)

    assert_equal se, rep.parent
  end

  def test_find_by_merchant_id_works
    se = SalesEngine.new({:items => "./test/fixtures/truncated_items.csv",
                         :merchants => "./test/fixtures/truncated_merchants.csv",
                         :invoices => "./test/fixtures/truncated_invoices.csv",
                         :invoice_items => "./test/fixtures/truncated_invoice_items.csv",
                         :transactions => "./test/fixtures/truncated_customers.csv",
                         :customers =>  "./test/fixtures/truncated_transactions.csv"})
    rep = ItemRepository.new("./test/fixtures/truncated_items.csv" , se)

    assert_equal Merchant, rep.find_by_merchant_id(12334105).class
  end
end
