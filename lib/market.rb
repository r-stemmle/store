class Market
  attr_reader :name,
              :vendors

  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    vendors << vendor
  end

  def vendor_names
    vendors.map(&:name)
  end

  def vendors_that_sell(item)
    vendors.find_all do |vendor|
      vendor.inventory.include?(item)
    end
  end

  def quantity_of_item_listed(item)
    vendors.sum { |vendor| vendor.check_stock(item) }
  end

  def items_being_sold
    vendors.flat_map { |vendor| vendor.inventory.keys }
  end

  def total_inventory
    total_inventory = {}
    items_being_sold.each do |item|
      total_inventory[item] = {
        quantity: quantity_of_item_listed(item),
        vendors: vendors_that_sell(item) }
    end
    total_inventory
  end

end
