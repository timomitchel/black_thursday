# require 'minitest/autorun'
# require_relative "../lib/merchant_repository"
# require "csv"
# require_relative "../lib/csv_reader"
#
# class MerchantRepositoryTest < Minitest::Test
#
#   def test_can_instantiate_merchant_repository_test
#     repository = MerchantRepository.new(CsvReader.csv_load("./data/merchants.csv"), self)
#
#     assert_instance_of MerchantRepository, repository
#   end
#
#   def test_data_is_our_objects
#     repository = MerchantRepository.new(CsvReader.csv_load("./data/merchants.csv"), self)
#     expected = repository.data
#
#     assert_equal expected, repository.data
#   end
#
#   def test_find_by_name
#     repository = MerchantRepository.new(CsvReader.csv_load("./data/merchants.csv"), self)
#     expected = repository.find_by_name("Candisart")
#
#     assert_equal expected, repository.find_by_name("Candisart")
#   end
#
#   def test_all_method
#     repository = MerchantRepository.new(CsvReader.csv_load("./data/merchants.csv"), self)
#
#     assert_equal repository.data, repository.all
#   end
#
#   def test_find_by_id
#     repository = MerchantRepository.new(CsvReader.csv_load("./data/merchants.csv"), self)
#     expected = repository.find_by_id("12334123")
#
#     assert_equal expected, repository.find_by_id("12334123")
#   end
#
#   def test_all_by_name
#     repository = MerchantRepository.new(CsvReader.csv_load("./data/merchants.csv"), self)
#     expected = repository.find_all_by_name("style")
#
#     assert_equal expected, repository.find_all_by_name("style")
#   end
#
# end
