require "./lib/item"
require "pry"
class ItemRepository

  attr_reader :data
  def initialize(data)
    @data = data.map {|line| Item.new(line)}
  end

  def find_by_name(item)
    current_item = data.find do |object|
      object.name.downcase == item.downcase
    end
    current_item
  end

  def all
    @data
  end

  def find_by_id(item)
    current_item = data.find do |object|
      object.id.to_i == item
    end
    current_item
  end

  def find_all_with_description(item)
    current_item = data.select do |object|
      object.description.downcase.include?(item.downcase)
    end
    current_item
  end

  def find_all_by_price(item)
    current_item = data.select do |object|
      object.unit_price.to_f == (item.to_f)
    end
    current_item
  end

  def find_all_by_price_in_range(item)
    current_item = data.select do |object|
      item.cover?(object.unit_price.to_f)
    end
    current_item
  end

  def find_all_by_merchant_id(item)
    current_item = data.select do |object|
      object.merchant_id.to_i == item
    end
    current_item
  end

end
