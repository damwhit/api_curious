require 'rails_helper'

RSpec.feature "AuthenticatedUserCanSeeDetailsOfPosts", type: :feature do
  before do
    @user = stub_omniauth
  end

  it "should show photo and likes and comments for a post" do
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

      expect(media[:data].length).to eq(11)

      VCR.use_cassette("instagram_service#post_media") do
        page.find("#image-#{first_post[:id]}").click

        post = PostMedia.find_by(@user["credentials"]["token"], first_post[:id])
        expect(page).to have_content("35 likes")

        post_comments = CommentMedia.all(@user["credentials"]["token"], first_post[:id])

        post_comments.each do |comment|
          expect(page).to have_content(comment.comment)
        end
      end
    end
  end
end
