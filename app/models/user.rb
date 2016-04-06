class User < ActiveRecord::Base
  def self.from_omniauth(auth_info)
    where(uid: auth_info[:uid]).first_or_create do |user|
      user.uid                = auth_info.uid
      user.name               = auth_info.info.name
      user.username           = auth_info.info.nickname
      user.email              = auth_info.info.email
      user.image_url          = auth_info.info.image
      user.bio                = auth_info.info.bio
      user.website            = auth_info.info.website
      user.token              = auth_info.credentials.token
      user.provider           = auth_info.provider
    end
  end
end
