require "bigdecimal"
require "time"
class Item

  attr_reader :id ,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id,
              :parent

  def initialize(data, parent)
    @id = data[:id].to_i
    @name = data[:name].downcase
    @description = data[:description].downcase
    @unit_price = BigDecimal.new(data[:unit_price])/100
    @created_at = Time.parse(data[:created_at])
    @updated_at = Time.parse(data[:updated_at])
    @merchant_id = data[:merchant_id].to_i
    @parent = parent
  end

  def merchant
    parent.find_by_merchant_id(merchant_id)
  end

end
