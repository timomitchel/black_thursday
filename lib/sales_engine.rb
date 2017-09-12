require './lib/merchant'
require "./lib/merchant_repository"
require "./lib/csv_reader"
require "pry"
require "./lib/item_repository"
class SalesEngine

  attr_reader :hash
  def initialize(hash)
    @hash = hash
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def merchants
    MerchantRepository.new(CsvReader.csv_load(hash[:merchants]))
  end

  def items
    ItemRepository.new(CsvReader.csv_load(hash[:items]))
  end
end
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
mr = se.items
p mr.find_all_by_merchant_id(12336477)
