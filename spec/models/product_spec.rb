# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    context 'creating a product with presence of all fields' do
      it 'should save successfully' do
        @category = Category.new(name: 'test')
        @product = @category.products.new(name: 'test', price: 100, quantity: 1)
        expect(@product.save).to be true
      end
    end

    context 'creating a product without a name' do
      it 'should fail to save' do
        @category = Category.new(name: 'test')
        @product = @category.products.new(name: nil, price: 100, quantity: 1)
        expect(@product.save).to be false
        expect(@product.errors.messages[:name]).to include("can't be blank")
      end
    end

    context 'creating a product without a price' do
      it 'should fail to save' do
        @category = Category.new(name: 'test')
        @product = @category.products.new(name: 'test', price: nil, quantity: 1)
        expect(@product.save).to be false
        expect(@product.errors.messages[:price]).to include("can't be blank")
      end
    end

    context 'creating a product without a quantity' do
      it 'should fail to save' do
        @category = Category.new(name: 'test')
        @product = @category.products.new(name: 'test', price: 100, quantity: nil)
        expect(@product.save).to be false
        expect(@product.errors.messages[:quantity]).to include("can't be blank")
      end
    end

    context 'creating an uncategorized product' do
      it 'should fail to save' do
        @product = Product.new(name: 'test', price: 100, quantity: 1)
        expect(@product.save).to be false
        expect(@product.errors.messages[:category]).to include("can't be blank")
      end
    end
  end
end
