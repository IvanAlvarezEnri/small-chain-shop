# frozen_string_literal: true

require 'product'

class PricingRules
  attr_reader :product_list

  def initialize
    @product_list = { 'GR1' => Product.new('Green Tea', 3.11),
                      'SR1' => Product.new('Strawberries', 5.00),
                      'CF1' => Product.new('Coffe', 11.23) }
  end

  def new_product(product_code, name, price)
    @product_list[product_code] = Product.new(name, price)
  end

  def delete_product(product_code)
    @product_list.delete(product_code)
  end
end
