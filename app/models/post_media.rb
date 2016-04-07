class PostMedia
  attr_reader :image_url,
              :username,
              :prof_pic,
              :caption,
              :location,
              :likes,
              :post_time,
              :comments

  def initialize(media, token)
    @image_url = media[:images][:standard_resolution][:url]
    @username = media[:user][:username]
    @prof_pic = media[:user][:profile_picture]
    @caption = media[:caption][:text] if !media[:caption].nil?
    @location = media[:location][:name] if !media[:location].nil?
    @likes = media[:likes][:count]
    @post_time = media[:created_time]
    @comments = CommentMedia.all(token, media[:id])
  end

  def self.service
    InstagramService.new
  end

  def self.find_by(token, post_id)
    PostMedia.new(service.post_media(token, post_id)[:data], token)
  end

  def format_time
    DateTime.strptime(post_time,'%s')
  end
  def self.all(token)
    user_ids = service.following(token)[:data].map { |user| user[:id] }
    user_media = user_ids.map do |uid|
      service.following_media(token, uid)[:data].map {
        |media| PostMedia.new(media, token)
      }
    end
    user_media.flatten.sort_by {|post| -post.post_time.to_i }
  end
end
