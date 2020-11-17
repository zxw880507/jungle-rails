require 'rails_helper'

RSpec.feature "Visitor navigates to product details page", type: :feature, js: true do
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

  scenario 'They see product details' do
    visit root_path
    click_on('Details', match: :first)
    expect(page).to have_css('.product-detail')
  end
end
