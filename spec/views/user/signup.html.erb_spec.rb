require 'rails_helper'

RSpec.describe "user/signup", type: :view do
  
  before do
    @user = User.create(
      name: 'TEST_USER',
      password: 'password1234',
    )
  end

  it '新規登録する' do
    visit signup_path
    fill_in 'name', with: '太郎'
    fill_in 'password', with: 'tarou1234'
    click_on '新規登録'
    expect(page).to have_current_path(root_path)
  end
  
  it 'ログインする' do
    visit login_path
    fill_in 'name', with: 'test@example.com'
    fill_in 'password', with: 'password1234'
    click_on 'ログイン'
    expect(page).to have_current_path(login_path)
  end
end
