# frozen_string_literal: true

require_relative 'pricing_rules'

# | This class works as a calculator and scanner.                           |
# | It will scan all the product inside our actual basket                   |
# | It will also reset the basket when needed  and calculate the total      |
# | We can have multiple RulePricing created and change it whenever we want |
# | For example if we want Summer discounts, we can create a price rule     |
# | and changed it only for Summer, then have another price rule to the rest|
# | of the year                                                             |

class Checkout
  attr_accessor :basket
  attr_reader :rules

  def initialize(pricing_rules)
    @rules = pricing_rules
    @basket = []
  end

  def change_rules(pricing_rules)
    @rules = pricing_rules if pricing_rules.is_a?(PricingRules)
  end

  def scan(prod_code)
    @basket << prod_code
  end

  def reset_basket
    @basket = []
  end

  def total
    total = 0
    basket.uniq.each do |product|
      total += rules.get_price(product, basket.count(product))
    end
    total
  end
end
