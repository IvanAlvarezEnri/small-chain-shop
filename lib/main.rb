# frozen_string_literal: true

require_relative 'checkout'
require_relative 'pricing_rules'

pricing_rules = PricingRules.new

co = Checkout.new(pricing_rules)
co.scan('GR1')
co.scan('SR1')
co.scan('GR1')
co.scan('GR1')
co.scan('CF1')
total = co.total
puts " Your total for #{co.basket.join(', ')} is £#{total}"
co.reset_basket

co.scan('GR1')
co.scan('GR1')
total = co.total
puts " Your total for #{co.basket.join(', ')} is £#{total}"
co.reset_basket

co.scan('SR1')
co.scan('SR1')
co.scan('GR1')
co.scan('SR1')
total = co.total
puts " Your total for #{co.basket.join(', ')} is £#{total}"
co.reset_basket

co.scan('GR1')
co.scan('CF1')
co.scan('SR1')
co.scan('CF1')
co.scan('CF1')
total = co.total
puts " Your total for #{co.basket.join(', ')} is £#{total}"
co.reset_basket
