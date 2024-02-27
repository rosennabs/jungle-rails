require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before(:each) do
      @category = Category.new(name: 'Test Category')
      @product = Product.new(
        name: 'Test Product',
        price_cents: 1000,
        quantity: 10,
        category: @category
      )
    end

    it 'should save successfully if all fields are set' do
      expect(@product.save).to be_truthy
    end

    it 'should validate presence of name' do
      @product.name = nil
      expect(@product.save).to be_falsey
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should validate presence of price' do
      @product.price_cents = nil
      expect(@product.save).to be_falsey
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should validate presence of quantity' do
      @product.quantity = nil
      expect(@product.save).to be_falsey
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should validate presence of category' do
      @product.category = nil
      expect(@product.save).to be_falsey
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
