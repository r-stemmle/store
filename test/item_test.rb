require 'minitest/autorun'
require 'minitest/pride'
require './lib/item'
require 'pry'


class ItemTest < Minitest::Test

  def test_it_exists
    item = Item.new({name: "Peach", price: "$0.50"})

    assert_instance_of Item, item
  end

  def test_it_has_attributes
    item = Item.new({name: "Peach", price: "$0.50"})

    assert_equal "Peach", item.name
    assert_equal 0.5, item.price
  end

end
