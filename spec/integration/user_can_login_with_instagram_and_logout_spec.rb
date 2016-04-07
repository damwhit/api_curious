require 'rails_helper'

RSpec.feature "UserLogsInWithInstagramAndLogsOut", type: :feature do
  before do
    @user = stub_omniauth
  end

  it "should redirect to homepage after logging out" do
    visit root_path
    VCR.use_cassette("instagram_service#user_info") do
      click_on "login with instagram"
      service = InstagramService.new
      info = service.user_info(@user["credentials"]["token"])

      expect(info[:data][:username]).to eq("damwhita")
      expect(current_path).to eq(user_path(info[:data][:username]))
      click_on "logout"
    end

    expect(current_path).to eq root_path

    visit posts_path

    expect(current_path).to eq root_path
  end
end
