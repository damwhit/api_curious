class PostMedia
  attr_reader :image_url,
              :username,
              :prof_pic,
              :caption,
              :location,
              :likes

  def initialize(media)
    @image_url = media[:images][:standard_resolution][:url]
    @username = media[:caption][:from][:username]
    @prof_pic = media[:caption][:from][:profile_picture]
    @caption = media[:caption][:text]
    @location = media[:location][:name]
    @likes = media[:likes][:count]
  end

  def self.service
    InstagramService.new
  end

  def self.find_by(token, post_id)
    PostMedia.new(service.post_media(token, post_id)[:data])
  end
end
