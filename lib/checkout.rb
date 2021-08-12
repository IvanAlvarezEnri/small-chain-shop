# frozen_string_literal: true

require 'pricing_rules'

class Checkout
  attr_accessor :basket
  attr_reader :rules

  def initialize(pricing_rules)
    @rules = pricing_rules
    @basket = []
  end

  #   def change_rules(pricing_rules)
  #     pricing_rules.instance_of? PricingRules ? @rules = pricing_rules : nil
  #   end

  def scan(prod_code)
    @basket << prod_code
  end

  def total
    total = 0
    basket.uniq.each do |product|
      total += rules.get_price(product, basket.count(product))
    end
    total
  end
end
