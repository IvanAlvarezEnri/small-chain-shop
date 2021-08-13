# frozen_string_literal: true

class Product
  attr_accessor :name, :price
  attr_reader :condition, :price_formula_true, :price_formula_false

  @price_formula_false = 'product_price * _amount'
  @price_formula_true = 'product_price * _amount'
  def initialize(name, price, condition = 'false', price_formula_true = 'product_price * _amount', price_formula_false = 'product_price * _amount')
    @name = name
    @price = price
    secure_condition(condition) ? @condition = condition : return
    @price_formula_true = secure_formula(price_formula_true) ? price_formula_true : 'product_price * _amount'
    @price_formula_false = secure_formula(price_formula_false) ? price_formula_false : 'product_price * _amount'
  end

  def add_discount(condition, price_formula_true, price_formula_false)
    secure_condition(condition) ? @condition = condition : return

    @price_formula_true = secure_formula(price_formula_true) ? price_formula_true : 'product_price * _amount'
    @price_formula_false = secure_formula(price_formula_false) ? price_formula_false : 'product_price * _amount'
  end

  def remove_discount
    @condition = 'false'
    @price_formula_true = 'product_price * _amount'
    @price_formula_false = 'product_price * _amount'
  end

  def secure_formula(formula)
    product_price = 10
    _amount = 3
    status = if formula.is_a?(String)
               formula.include?('product_price') && formula.include?('_amount') && eval(formula).is_a?(Numeric)
             else
               false
             end
  end

  def secure_condition(condition)
    product_price = 10
    _amount = 3
    status = if condition.is_a?(String)
               !!eval(condition) == eval(condition)
             else
               false
             end
  end
end
