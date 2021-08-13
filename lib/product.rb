# frozen_string_literal: true

class Product
  attr_accessor :name, :price
  attr_reader :condition, :price_formula_true, :price_formula_false

  def initialize(name, price, condition = false, price_formula_true = nil, price_formula_false = 'product_price * _amount')
    @name = name
    @price = price
    @condition = condition
    @price_formula_true = price_formula_true
    @price_formula_false = price_formula_false
  end
end
