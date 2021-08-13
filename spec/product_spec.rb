# frozen_string_literal: true

require 'product'

RSpec.describe Product do
  it 'creates a product class' do
    product = Product.new('test', 1)
    expect(product).to be_kind_of(Product)
    expect(product.name).to eq 'test'
  end

  it 'creates a new discount' do
    product = Product.new('test', 1)
    product.add_discount('_amount > 1', 'product_price * _amount / 2', 'product_price * _amount')
    expect(product.condition).to eq '_amount > 1'
    expect(product.price_formula_true).to eq 'product_price * _amount / 2'
    expect(product.price_formula_false).to eq 'product_price * _amount'
  end

  it 'creates an incorrect discount, bad condition' do
    product = Product.new('test', 1)
    product.add_discount(2, 'product_price * _amount / 2', 'product_price * _amount')
    expect(product.condition).to eq 'false'
    expect(product.price_formula_true).to eq 'product_price * _amount'
    expect(product.price_formula_false).to eq 'product_price * _amount'
  end

  it 'creates an incorrect discount, bad formula' do
    product = Product.new('test', 1)
    product.add_discount('true', 2, nil)
    expect(product.condition).to eq 'true'
    expect(product.price_formula_true).to eq 'product_price * _amount'
    expect(product.price_formula_false).to eq 'product_price * _amount'
  end

  it 'delete discount' do
    product = Product.new('test', 1)
    product.add_discount('_amount > 1', 'product_price * _amount / 2', 'product_price * _amount')
    expect(product.price_formula_true).to eq 'product_price * _amount / 2'
    product.remove_discount
    expect(product.price_formula_true).to eq 'product_price * _amount'
  end
end
