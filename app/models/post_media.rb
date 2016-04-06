class PostMedia
  def self.service
    InstagramService.new
  end

  def self.find_by(token, post_id)
    build_object(service.post_media(token, post_id))[:data]
  end

  private
    def self.build_object(data)
      OpenStruct.new(data)
    end
end
