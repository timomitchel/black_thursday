class Merchant

  attr_reader :name, :id, :created_at, :updated_at, :parent

  def initialize(data, parent)
     @name = data[:name]
     @id = data[:id]
     @created_at = data[:created_at]
     @updated_at = data[:updated_at]
     @parent = parent
  end

  def items
    parent.find_items_by_merchant(id)
  end

end
