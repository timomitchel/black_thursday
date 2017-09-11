require './lib/merchant'
require "./lib/merchant_repository"
require "./lib/csv_reader"
require "pry"
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

end
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
mr = se.merchants
puts mr.find_by_name('Candisart')
