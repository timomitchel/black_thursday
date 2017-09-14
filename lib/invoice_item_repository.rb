class InvoiceItemRepository
  def initialize(data, parent)
    @data = data
    @parent = parent
  end

  def inspect
     "#{self.class}"
  end
end
