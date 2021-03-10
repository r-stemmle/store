class Market
  attr_reader :name,
              :vendors,
              :time_date

  def initialize(name)
    @name = name
    @vendors = []
    @time_date = Time.now
  end

  def sorted_item_list
    sorted_items.map(&:name)
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
    end.uniq
  end

  def quantity_of_item_listed(item)
    vendors.sum { |vendor| vendor.check_stock(item) }
  end

  def sorted_items
    vendors.flat_map { |vendor| vendor.inventory.keys }.uniq
           .sort_by(&:name)
  end

  def total_inventory
    total_inventory = {}
    sorted_items.each do |item|
      total_inventory[item] = {
        quantity: quantity_of_item_listed(item),
        vendors: vendors_that_sell(item) }
    end
    total_inventory
  end

  def overstocked_items
    sorted_items.find_all do |item|
      quantity_of_item_listed(item) > 50 && vendors_that_sell(item).length > 1
    end.uniq
  end

  def date
  end

end
