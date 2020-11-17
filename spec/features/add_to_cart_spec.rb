# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'Visitor adds products to cart', type: :feature, js: true do
  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |_n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end

  scenario 'The cart in top nav should be updated to 1 if a product is added' do
    visit root_path
    expect(page.find('nav', text: 'My Cart')).to have_content('0')
    click_on('Add', match: :first)
    expect(page.find('nav', text: 'My Cart')).to have_content('1')
  end
end
