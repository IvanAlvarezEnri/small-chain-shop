# frozen_string_literal: true

require_relative 'product'
# | This class manage the avalaible product list and the active discounts |
# | This class manage the avalaible product code of each product too      |
# | It also calculate the final price of a product                        |
# | giving the amount and product code                                    |
class PricingRules
  attr_reader :product_list

  def initialize
    @product_list = { 'GR1' => Product.new('Green Tea', 3.11, '_amount.even?', 'product_price * _amount / 2', 'product_price * ((_amount - 1) / 2 + 1)'),
                      'SR1' => Product.new('Strawberries', 5.00, '_amount >= 3', '(product_price - 0.5) * _amount'),
                      'CF1' => Product.new('Coffe', 11.23, '_amount >= 3', '(product_price * 2 / 3) * _amount') }
  end

  # Calling new_product you will add a new product to the product list
  # and add an instant discount if needed,
  # be sure that condition and price formula use 'product_price' for the price and '_amount' for the amount
  # these are the variables that the discount system use to do his magic.
  def new_product(product_code, name, price, condition = 'false', price_formula_true = 'product_price * _amount', price_formula_false = 'product_price * _amount')
    @product_list[product_code] = Product.new(name, price, condition, price_formula_true, price_formula_false)
  end

  # Delete product from the product list
  def delete_product(product_code)
    @product_list.delete(product_code)
  end

  # Calling add_discount you will add a new discount for a product of the product list
  # be sure that condition and price formula use 'product_price' for the price and '_amount' for the amount
  # these are the variables that the discount system use to do his magic.
  def add_discount(product, condition, price_formula_true, price_formula_false = 'product_price * _amount')
    product_list[product].add_discount(condition, price_formula_true, price_formula_false)
  end

  # Remove discount of an existing product.
  def remove_discount(product)
    product_list[product].remove_discount
  end

  # Get price formula, check if condition succes, and giveone of the two
  # possible scenarios. Round the number to 2 automatically.
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
