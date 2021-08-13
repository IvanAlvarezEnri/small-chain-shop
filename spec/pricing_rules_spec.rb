# frozen_string_literal: true

require 'pricing_rules'

RSpec.describe PricingRules do
  context 'product list test' do
    it 'creates a PricingRules class' do
      pricing_rules = PricingRules.new
      expect(pricing_rules).to be_kind_of(PricingRules)
      expect(pricing_rules.product_list['CF1'].name).to eq 'Coffe'
    end

    it 'creates a PricingRules class with new product' do
      pricing_rules = PricingRules.new
      pricing_rules.new_product('HM1', 'Ham', 1)
      expect(pricing_rules).to be_kind_of(PricingRules)
      expect(pricing_rules.product_list['HM1'].name).to eq 'Ham'
      expect(pricing_rules.product_list['HM1'].price).to eq 1
    end

    it ' creates PricingRules class and delete product' do
      pricing_rules = PricingRules.new
      pricing_rules.delete_product('CF1')

      expect(pricing_rules.product_list['CF1']).to eq nil
    end
  end

  context 'product list test' do
    pricing_rules = PricingRules.new

    it 'verify 2x1 price rule on Green Tea works' do
      expect(pricing_rules.get_price('GR1', 1)).to eq 3.11
      expect(pricing_rules.get_price('GR1', 2)).to eq 3.11
      expect(pricing_rules.get_price('GR1', 3)).to eq 6.22
      expect(pricing_rules.get_price('GR1', 4)).to eq 6.22
      expect(pricing_rules.get_price('GR1', 10)).to eq 15.55
      expect(pricing_rules.get_price('GR1', 11)).to eq 18.66
    end

    it 'verify strawberries low price rule' do
      expect(pricing_rules.get_price('SR1', 1)).to eq 5.0
      expect(pricing_rules.get_price('SR1', 3)).to eq 13.5
      expect(pricing_rules.get_price('SR1', 10)).to eq 45.00
    end

    it ' verify coffee lover rule, price drop to 2/3 of his original price' do
      expect(pricing_rules.get_price('CF1', 1)).to eq 11.23
      expect(pricing_rules.get_price('CF1', 3)).to eq 22.46
      expect(pricing_rules.get_price('CF1', 10)).to eq 74.87
    end

    it 'creates a new discount' do
      pricing_rules.new_product('HM1', 'Ham', 10)
      pricing_rules.add_discount('HM1', '_amount > 2 ', 'product_price * (_amount-1)')
      expect(pricing_rules.get_price('HM1', 1)).to eq 10
      expect(pricing_rules.get_price('HM1', 3)).to eq 20
      expect(pricing_rules.get_price('HM1', 4)).to eq 30
    end

    it 'remove a discount' do
      pricing_rules.remove_discount('HM1')
      expect(pricing_rules.get_price('HM1', 1)).to eq 10
      expect(pricing_rules.get_price('HM1', 3)).to eq 30
      expect(pricing_rules.get_price('HM1', 4)).to eq 40
    end
  end
end
