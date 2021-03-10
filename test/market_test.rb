require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/market'
require './lib/vendor'
require 'mocha/minitest'

class MarketTest < Minitest::Test

  def setup
    @vendor1 = Vendor.new("Rocky Mountain Fresh")

    @item1 = Item.new({name: 'Peach', price: "$0.75"})

    @item2 = Item.new({name: 'Tomato', price: "$0.50"})

    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})

    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})

    @vendor2 = Vendor.new("Ba-Nom-a-Nom")

    @vendor3 = Vendor.new("Palisade Peach Shack")
  end
  def test_it_exists
    market = Market.new("South Pearl")

    assert_instance_of Market, market
  end

  def test_it_has_attributes
    market = Market.new("South Pearl")

    assert_equal "South Pearl", market.name
    assert_equal [], market.vendors
  end

  def test_a_market_can_add_vendors
    market = Market.new("South Pearl")
    market.add_vendor(@vendor1)

    assert_equal [@vendor1], market.vendors
  end

  def test_it_can_get_list_of_vendors_names
    market = Market.new("South Pearl")
    market.add_vendor(@vendor1)

    assert_equal ["Rocky Mountain Fresh"], market.vendor_names
  end

  def test_market_can_list_vendors_that_sell_specific_item
    market = Market.new("South Pearl")
    @vendor1.stock(@item1, 35)
    @vendor1.stock(@item2, 7)
    @vendor2.stock(@item4, 50)
    @vendor2.stock(@item3, 25)
    @vendor3.stock(@item1, 65)
    market.add_vendor(@vendor1)
    market.add_vendor(@vendor2)
    market.add_vendor(@vendor3)

    assert_equal [@vendor1, @vendor3], market.vendors_that_sell(@item1)
  end

  def test_market_can_list_quantity_of_items_listed
    market = Market.new("South Pearl")
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(item2, 35)
    market.add_vendor(vendor1)

    assert_equal 35, market.quantity_of_item_listed(item2)
  end

  def test_a_market_can_list_total_inventory
    # skip
    market = Market.new("South Pearl")
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(item2, 35)
    market.add_vendor(vendor1)

    expected = { item2 => { quantity: 35, vendors: [vendor1] } }
    assert_equal expected, market.total_inventory
  end

  def test_market_can_list_all_items_being_sold
    market = Market.new("South Pearl")
    item2 = Item.new({name: 'Tomato', price: "$0.50"})
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(item2, 35)
    vendor1.stock(@item1, 35)
    market.add_vendor(vendor1)
    @vendor2.stock(@item1, 10)

    assert_equal [item2, @item1], market.items_being_sold
  end

end
