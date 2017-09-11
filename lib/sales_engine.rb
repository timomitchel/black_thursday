require './lib/merchants'
require 'csv'
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
    hash[:merchants]
  end

end
se = SalesEngine.from_csv({
  :items     => "./data/items.csv",
  :merchants => "./data/merchants.csv",
})
puts mr = se.
