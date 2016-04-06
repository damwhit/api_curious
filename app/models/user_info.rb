class UserInfo
  def self.service
    InstagramService.new
  end

  def self.all(token)
    build_object(service.user_info(token)[:data])
  end

  private
    def self.build_object(data)
      OpenStruct.new(data)
    end
end
