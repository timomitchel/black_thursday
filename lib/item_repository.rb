require_relative "item"
require 'csv'
class ItemRepository

  attr_reader :data, :parent
  def initialize(data, parent=nil)
    @data = csv_load(data).map {|row| Item.new(row, self)}
    @parent = parent
  end

  def csv_load(file_path)
   CSV.open file_path, headers: true, header_converters: :symbol
  end

  def find_by_merchant_id(merchant_id)
    parent.find_by_merchant_id(merchant_id)
  end

  def find_by_name(item)
    data.find {|object| object.name.downcase == item.downcase}
  end

  def all
    @data
  end

  def find_by_id(item)
    data.find {|object| object.id == item}
  end

  def find_all_with_description(item)
    data.select {|object| object.description.downcase.include?(item.downcase)}
  end

  def find_all_by_price(item)
    data.select {|object|object.unit_price.to_f == (item.to_f)}
  end

  def find_all_by_price_in_range(item)
    data.select {|object| item.cover?(object.unit_price.to_f)}
  end

  def find_all_by_merchant_id(item)
    all_items = data.select{|object|object.merchant_id == item}
  end

  def inspect
     "#{self.class}"
  end

end
