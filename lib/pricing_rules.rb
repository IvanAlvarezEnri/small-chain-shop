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

  def get_price(product, amount)
    product_price = product_list[product].price
    price = case product
            when 'GR1'
              amount.even? == true ? product_price * amount / 2 : product_price * ((amount - 1) / 2 + 1)
            when 'SR1'
              amount >= 3 ? (product_price - 0.5) * amount : product_price * amount
            when 'CF1'
              amount >= 3 ? (product_price * 2 / 3) * amount : product_price * amount
            else
              product_price * amount
            end
    price.round(2)
  end
end
