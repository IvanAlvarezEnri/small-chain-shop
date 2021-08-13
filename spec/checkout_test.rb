# frozen_string_literal: true

require 'checkout'
require 'pricing_rules'

RSpec.describe Checkout do
  context 'Class creation and methods' do
    it 'creates a checkout class' do
      pricing_rules = PricingRules.new
      checkout = Checkout.new(pricing_rules)
      expect(checkout).to be_kind_of(Checkout)
    end

    it 'add product to basket' do
      pricing_rules = PricingRules.new
      checkout = Checkout.new(pricing_rules)
      checkout.scan('GR1')
      expect(checkout.basket[0]).to eq 'GR1'
    end

    it 'change rules' do
      pricing_rules = PricingRules.new
      checkout = Checkout.new(pricing_rules)
      expect(checkout.rules.product_list['GR1'].name).to eq 'Green Tea'
      pricing_rulesFalse = PricingRules.new
      pricing_rulesFalse.delete_product('GR1')
      checkout.change_rules(pricing_rulesFalse)
      expect(checkout.rules.product_list['GR1']).to eq nil
    end
  end

  context 'final tests' do
    pricing_rules = PricingRules.new
    it 'Basket: GR1,SR1,GR1,GR1,CF1' do
      co = Checkout.new(pricing_rules)
      co.scan('GR1')
      co.scan('SR1')
      co.scan('GR1')
      co.scan('GR1')
      co.scan('CF1')
      total = co.total
      expect(total).to eq 22.45
    end
    it 'Basket: GR1,GR1' do
      co = Checkout.new(pricing_rules)
      co.scan('GR1')
      co.scan('GR1')
      total = co.total
      expect(total).to eq 3.11
    end
    it 'Basket: SR1,SR1,GR1,SR1' do
      co = Checkout.new(pricing_rules)
      co.scan('SR1')
      co.scan('SR1')
      co.scan('GR1')
      co.scan('SR1')
      total = co.total
      expect(total).to eq 16.61
    end
    it 'Basket: GR1,CF1,SR1,CF1,CF1' do
      co = Checkout.new(pricing_rules)
      co.scan('GR1')
      co.scan('CF1')
      co.scan('SR1')
      co.scan('CF1')
      co.scan('CF1')
      total = co.total
      expect(total).to eq 30.57
    end
  end
end
