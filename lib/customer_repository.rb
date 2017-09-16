require_relative 'customer'
require 'csv'

class CustomerRepository
  attr_reader :data, :parent

  def initialize(data, parent)
    @data = csv_load(data).map {|row| Customer.new(row, self)}
    @parent = parent
  end

  def csv_load(file_path)
   CSV.open file_path, headers: true, header_converters: :symbol
  end

  def all
    @data
  end

  def find_by_id(customer_id)
    data.find {|object| object.id == customer_id}
  end

  def find_all_by_first_name(name)
    data.select {|object| object.first_name.downcase.include?(name.downcase)}
  end

  def find_all_by_last_name(name)
    data.select {|object| object.last_name.downcase.include?(name.downcase)}
  end

  def inspect
    "#{self.class}"
  end
end
