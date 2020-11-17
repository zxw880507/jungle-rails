# frozen_string_literal: true

require 'rails_helper'

RSpec.feature 'UserLogins', type: :feature, js: true do
  before :each do
    User.create!(
      first_name: 'Jack',
      last_name: 'Zhao',
      email: 'jack@gmail.com',
      password: '111111',
      password_confirmation: '111111'
    )
  end

  scenario 'User can login successfully' do
    visit root_path
    click_on 'Login'
    expect(page.find('main h1')).to have_content('Login')
    fill_in 'email', with: 'jack@gmail.com'
    fill_in 'password', with: '111111'
    click_on 'Submit'
    expect(page.find('nav', text: 'Signed in as'))
      .to have_content('jack@gmail.com')
    expect(page.find('nav')).to have_content('Logout')
  end
end
