# require './lib/item_repository'
# require 'minitest/autorun'
# require './lib/csv_reader'
#
# class ItemRepositoryTest < Minitest::Test
#   def setup
#     @repository = ItemRepository.new(CsvReader.csv_load("./data/items.csv") , self)
#   end
#
#   def test_if_class_item_repository_exist
#     assert_instance_of ItemRepository, @repository
#   end
#
#   def test_if_find_by_name_works
#     expected = @repository.find_by_name("Intricate Sunset")
#
#     assert_equal expected, @repository.find_by_name("Intricate Sunset")
#   end
#
#   def test_find_by_id_works
#     # expected = @repository.find_by_id()
#   end
# end
