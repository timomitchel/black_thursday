require './lib/item_repository'
require 'minitest/autorun'

class ItemRepositoryTest < Minitest::Test
  attr_reader :repository
  def setup
    @repository = ItemRepository.new("./test/fixtures/truncated_items.csv" , self)
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
end
