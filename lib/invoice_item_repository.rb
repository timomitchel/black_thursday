require_relative 'invoice_item'
require 'csv'

class InvoiceItemRepository
  attr_reader :data, :parent

  def initialize(data, parent)
    @data = csv_load(data).map{|line| InvoiceItem.new(line, self)}
    @parent = parent
  end

  def csv_load(file_path)
   CSV.open file_path, headers: true, header_converters: :symbol
  end

  def all
    @data
  end

  def find_by_id(item_id)
    data.find {|object| object.id == item_id}
  end

  def find_all_by_item_id(id)
    data.select {|object| object.item_id == id}
  end

  def find_all_by_invoice_id(id)
    data.select {|object| object.invoice_id == id}
  end

  def inspect
    "#{self.class}"
  end

end
