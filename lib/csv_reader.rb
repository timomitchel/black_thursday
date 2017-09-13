require 'csv'
# require 'pry'
class CsvReader

  def self.csv_load(file)
    CSV.open "#{file}", headers: true, header_converters: :symbol
  end


end
