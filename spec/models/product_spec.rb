require 'rails_helper'

RSpec.describe Product, type: :model do
 
  describe 'Validations' do
    it 'should create a product with all fields and save' do
      @category = Category.new(name: "category_test")
      @category.save
      @product = Product.new(name: "name_test" , price: 100, quantity: 5, category: @category)
      @product.save
      expect(@product.id).to be_present
    end

    it 'should error when the name is empty' do
      @category = Category.new(name:"category_test")
      @product = Product.new(name: nil , price: 100, quantity: 5, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
      
    
    end

    it 'should error when the price is empty' do
      @category = Category.new(name:"category_test")
      @product = Product.new(name: "name_test" , price_cents: nil, quantity: 5, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price cents is not a number")
    
    end

    it 'should error when the quantity is empty' do
      @category = Category.new(name:"category_test")
      @category.save
      @product = Product.new(name: "name_test" , price: 100, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    
    end

    it 'should error when the catyegory is empty' do
      @product = Product.new(name: "name_test" , price: 100, quantity: 5, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    
    end
  end
end







