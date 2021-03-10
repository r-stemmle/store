class Vendor
  attr_reader :name,
              :inventory

  def initialize(name)
    @name = name
    @inventory = Hash.new { |hash, key| hash[key] = 0 }
  end

  def potential_revenue
    inventory.sum { |item, quantity| (item.price * quantity) }
             .round(2)
  end

  def stock(item, amount)
    inventory[item] += amount
  end

  def check_stock(item)
    inventory[item]
  end
end
