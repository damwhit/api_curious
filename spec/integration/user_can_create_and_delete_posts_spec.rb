require 'rails_helper'

RSpec.feature "UserCanAddAndRemoveComments", type: :feature do
  before do
    @user = stub_omniauth
  end

  it "should show added post and remove post" do
    visit root_path

    VCR.use_cassette("instagram_service#user_info") do
      click_on "login with instagram"
      service = InstagramService.new
      service.user_info(@user["credentials"]["token"])
    end

    VCR.use_cassette("instagram_service#user_media") do
      service = InstagramService.new
      media = service.user_media(@user["credentials"]["token"])
      first_post = media[:data][0]

      visit "/posts/#{first_post[:id]}"

      within("#comment-form") do
        fill_in "comment", with: "test comment"
        click_on "comment"
      end

      expect(page).to have_content("test comment")
    end
  end
end
