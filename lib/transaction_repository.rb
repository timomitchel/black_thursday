require_relative 'transaction'
require 'csv'

class TransactionRepository
  
  attr_reader :data, :parent

  def initialize(data, parent)
    @data = csv_load(data).map {|row| Transaction.new(row, self)}
    @parent = parent
  end

  def find_invoice_by_transaction_id(id)
    parent.find_invoice_by_transaction_id(id)
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

  def find_all_by_invoice_id(id)
    data.select {|object| object.invoice_id == id}
  end

  def find_all_by_credit_card_number(number)
    data.select {|object| object.credit_card_number == number}
  end

  def find_all_by_result(status)
    data.select {|object| object.result == status}
  end

  def inspect
    "#{self.class}"
  end
end
