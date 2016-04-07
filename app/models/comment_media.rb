class CommentMedia
  attr_reader :username,
              :comment

  def initialize(media)
    @username = media[:from][:username]
    @comment = media[:text]
  end

  def self.service
    InstagramService.new
  end

  def self.create(token, post_id, comment)
    service.create_comment(token, post_id, comment)
  end

  def self.all(token, post_id)
    service.comments(token, post_id)[:data].map {
      |comment| CommentMedia.new(comment)
    }
  end
end
