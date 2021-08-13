# frozen_string_literal: true

require 'product'

class PricingRules
  attr_reader :product_list

  def initialize
    @product_list = { 'GR1' => Product.new('Green Tea', 3.11, '_amount.even?', 'product_price * _amount / 2', 'product_price * ((_amount - 1) / 2 + 1)'),
                      'SR1' => Product.new('Strawberries', 5.00, '_amount >= 3', '(product_price - 0.5) * _amount'),
                      'CF1' => Product.new('Coffe', 11.23, '_amount >= 3', '(product_price * 2 / 3) * _amount') }
  end

  def new_product(product_code, name, price, condition = 'false', price_formula_true = 'product_price * _amount', price_formula_false = 'product_price * _amount')
    @product_list[product_code] = Product.new(name, price, condition, price_formula_true, price_formula_false)
  end

  def delete_product(product_code)
    @product_list.delete(product_code)
  end

  def add_discount(product, condition, price_formula_true, price_formula_false = 'product_price * _amount')
    product_list[product].add_discount(condition, price_formula_true, price_formula_false)
  end

  def remove_discount(product)
    product_list[product].remove_discount
  end

  def get_price(product, _amount)
    product_price = product_list[product].price
    price = if eval(product_list[product].condition)
              eval(product_list[product].price_formula_true)
            else
              eval(product_list[product].price_formula_false)
            end
    price.round(2)
  end
end
