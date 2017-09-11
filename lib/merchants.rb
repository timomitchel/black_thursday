require "./lib/find_by_name"

class Merchant

  attr_reader :data

  def initialize(data)
    @data = data

  end

  def merchants
    FindByName.new(@data[:merchants][:name])
  end


end
