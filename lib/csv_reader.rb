require 'csv'
require 'pry'
class CsvReader

  def self.csv_load(file)
    contents = CSV.open "#{file}", headers: true, header_converters: :symbol

  end


end
