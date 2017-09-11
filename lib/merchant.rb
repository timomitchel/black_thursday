class Merchant

  attr_reader :name, :id, :created_at, :updated_at

  def initialize(data)
     @name = data[:name]
     @id = data[:id]
     @created_at = data[:created_at]
     @updated_at = data[:updated_at]

  end

end
