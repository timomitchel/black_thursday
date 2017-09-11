require 'csv'
require 'pry'
class Loader

  def self.csv_load(file)
    contents = CSV.open "#{file}", headers: true, header_converters: :symbol
  end


end

Loader.csv_load('./data/merchants.csv')
