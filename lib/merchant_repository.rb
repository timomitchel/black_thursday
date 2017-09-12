require "./lib/merchant"
require "pry"

class MerchantRepository
  attr_reader :data, :parent
  def initialize(data, parent)
    @data = data.map {|line| Merchant.new(line, self)}
    @parent = parent
  end

  def find_items_by_merchant(id)
    parent.find_items_by_merchant(id)
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
    data.find do |object|
      object.id.to_i == merchant.to_i
    end
  end

  def find_all_by_name(merchant)
    current_merchant = data.select do |object|
      object.name.downcase.include?(merchant.downcase)
    end
    current_merchant
  end

end