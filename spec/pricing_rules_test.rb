# frozen_string_literal: true

require 'pricing_rules'

RSpec.describe PricingRules do
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
