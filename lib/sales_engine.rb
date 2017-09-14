require './lib/merchant'
require "./lib/merchant_repository"
require "./lib/item_repository"
require "./lib/invoice_repository"
class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices
  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants],self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
  end

  def self.from_csv(hash)
    SalesEngine.new(hash)
  end

  def find_items_by_merchant(merchant_id)
    items.find_all_by_merchant_id(merchant_id)
  end

  def find_by_merchant_id(merchant)
    merchants.find_by_id(merchant)
  end

  def find_invoices_by_merchant(id)
    invoices.find_all_by_merchant_id(id)
  end
end
