require "./lib/item"
require 'csv'
require "pry"
class ItemRepository

  attr_reader :data, :parent
  def initialize(data, parent)
    @data = data.map {|line| Item.new(line, self)}
    @parent = parent
  end

  def find_by_merchant_id(merchant_id)
    parent.find_by_merchant_id(merchant_id)
  end

  def find_by_name(item)
    current_item = data.find do |object|
      object.name.downcase == item.downcase
    end
    return nil if current_item.nil?
    current_item
  end

  def all
    @data
  end

  def find_by_id(item)
    data.find do |object|
      object.id.to_i == item.to_i
    end
  end

  def find_all_with_description(item)
    current_item = data.select do |object|
      object.description.downcase.include?(item.downcase)
    end
    return [] if current_item.nil?
    current_item
  end

  def find_all_by_price(item)
    current_item = data.select do |object|
      object.unit_price.to_f == (item.to_f)
    end
    return [] if current_item.nil?
    current_item
  end

  def find_all_by_price_in_range(item)
    current_item = data.select do |object|
      item.cover?(object.unit_price.to_f)
    end
    return [] if current_item.nil?
    current_item
  end

  def find_all_by_merchant_id(item)
    all_items = data.select do |object|
      object.merchant_id.to_i == item.to_i
    end
    return [] if all_items.nil?
    all_items
  end

end
