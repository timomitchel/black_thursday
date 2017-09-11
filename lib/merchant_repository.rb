require "./lib/merchant"
require "pry"

class MerchantRepository
  attr_reader :data
  def initialize(data)
    @data = data.map {|line| Merchant.new(line)}
  end

  def find_by_name(merchant)
    c = data.find do |m|
      m.name == merchant
    end
    c
  end



end
