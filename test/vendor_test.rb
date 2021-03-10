require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require './lib/vendor'
require 'mocha/minitest'

class VendorTest < Minitest::Test

  def test_it_exists
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_instance_of Vendor, vendor
  end

  def test_it_has_attributes
    vendor = Vendor.new("Rocky Mountain Fresh")

    assert_equal "Rocky Mountain Fresh", vendor.name
    assert_equal ({}), vendor.inventory
  end

  def test_it_has_0_of_item_by_default
    vendor = Vendor.new("Rocky Mountain Fresh")
    item = mock("item")

    assert_equal 0, vendor.check_stock(item)
  end

  def test_vendor_can_stock_item
    vendor = Vendor.new("Rocky Mountain Fresh")
    item = Item.new({name: "Peach", price: "$0.50"})
    vendor.stock(item, 30)

    expected = { item => 30 }
    assert_equal expected, vendor.inventory
    assert_equal 30, vendor.check_stock(item)

    vendor.stock(item, 25)
    assert_equal 55, vendor.check_stock(item)
  end

  def test_a_vendor_can_calculate_their_potential_revenue
    vendor = Vendor.new("Rocky Mountain Fresh")
    item = Item.new({name: "Peach", price: "$0.50"})
    vendor.stock(item, 30)
    vendor.stock(item, 25)

    assert_equal 27.50, vendor.potential_revenue
    # puts vendor.potential_revenue
  end


end
