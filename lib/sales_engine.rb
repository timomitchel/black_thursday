require './lib/merchants'
require 'csv'
require "./data/merchants.csv"
require "./data/items.csv"
class SalesEngine

  def initialize
    @hash = @hash

  end

  def self.from_csv(files_hash)
    data = files_hash.each_pair do |key, value|
      value = CSV.open "#{value}", headers: true, header_converters: :symbol
    end
    Merchants.new(data)
  end

end
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
puts mr = se.merchants
puts merchant = mr.find_by_name("CJsDecor")
