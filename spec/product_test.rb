# frozen_string_literal: true

require 'product'

RSpec.describe Product do
  it 'creates a product class' do
    product = Product.new('test', 1)
    expect(product).to be_kind_of(Product)
    expect(product.name).to eq 'test'
  end
end
