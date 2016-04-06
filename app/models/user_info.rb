class UserInfo
  attr_reader :posts,
              :followers,
              :following

  def initialize(info)
    @posts = info[:counts][:media]
    @followers = info[:counts][:followed_by]
    @following = info[:counts][:follows]
  end

  def self.service
    InstagramService.new
  end

  def self.all(token)
    UserInfo.new(service.user_info(token)[:data])
  end
end
