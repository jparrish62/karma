require 'rails_helper'

feature 'Sign in', :devise do
  scenario 'user cannot sign in if not registered' do
    @user = FactoryGirl.build(:user)
    sign_in(@user)
    expect(page).to have_content 'Salon Karma'
  end
end
