require "./lib/item"
require "pry"
class ItemRepository

  attr_reader :data
  def initialize(data)
    @data = data.map {|line| Item.new(line)}
  end

  def find_by_name(item)
    current_item = data.find do |object|
      # puts object.name
      # binding.pry
      object.name.downcase == item.downcase
    end
    current_item
  end





end
