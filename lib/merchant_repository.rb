require "./lib/merchant"
require "pry"

class MerchantRepository
  attr_reader :data
  def initialize(data)
    @data = data.map {|line| Merchant.new(line)}
  end

  def find_by_name(merchant)
    current_merchant = data.find do |object|
      object.name.downcase == merchant.downcase
    end
    current_merchant
  end

  def all
    @data
  end

  def find_by_id(merchant)
    current_merchant = data.find do |object|
      object.id.to_i == merchant
    end
    current_merchant
  end

  def find_all_by_name(merchant)
    current_merchant = data.select do |object|
      object.name.downcase.include?(merchant.downcase)
    end
    current_merchant
  end

end
