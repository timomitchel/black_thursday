require './lib/merchant'
require "./lib/merchant_repository"
require "./lib/csv_reader"
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
    MerchantRepository.new(CsvReader.csv_load(hash[:merchants]),self)
  end

  def find_items_by_merchant(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def items
    ItemRepository.new(CsvReader.csv_load(hash[:items]), self)
  end

  def find_by_merchant_id(merchant)
    merchants.find_by_id(merchant)
  end
end
