require_relative 'merchant'
require_relative "merchant_repository"
require_relative "item_repository"
require_relative "invoice_repository"
require_relative "invoice_item_repository"
require_relative "transaction_repository"
require_relative "customer_repository"

class SalesEngine

  attr_reader :items,
              :merchants,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(hash)
    @items = ItemRepository.new(hash[:items], self)
    @merchants = MerchantRepository.new(hash[:merchants],self)
    @invoices = InvoiceRepository.new(hash[:invoices], self)
    @invoice_items = InvoiceItemRepository.new(hash[:invoice_items], self)
    @transactions = TransactionRepository.new(hash[:transactions], self)
    @customers = CustomerRepository.new(hash[:customers], self)
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

  def find_merchant_by_invoice(merchant)
    merchants.find_by_id(merchant)
  end

  def find_item_by_invoice_id(id)
    invoice_items.find_all_by_invoice_id(id).map do |invoice|
      items.find_by_id(invoice.item_id )
    end
  end

  def find_transaction_by_invoice_id(id)
    transactions.find_all_by_invoice_id(id)
  end

  def find_customer_by_invoice_id(id)
    customer.find_by_id(id)
  end

end
