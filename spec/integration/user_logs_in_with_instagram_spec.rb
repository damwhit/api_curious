require "rails_helper"

RSpec.feature "User can log in with instagram" do
  before do
    Capybara.app = ApiCurious::Application
    stub_omniauth
  end

  scenario "They can successfully log in" do
    visit "/"
    expect(page.status_code).to eq(200)
    click_link "login"
    expect(current_path).to eq("/")
    expect(page).to have_content("David")
    expect(page).to have_content("logout")
  end
end
