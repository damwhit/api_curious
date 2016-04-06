class UserMedia
  attr_reader :image_url,
              :id

  def initialize(media)
    @id = media[:id]
    @image_url = media[:images][:low_resolution][:url]
  end

  def self.service
    InstagramService.new
  end

  def self.all(token)
    service.user_media(token)[:data].map { |media| UserMedia.new(media) }
  end
end
