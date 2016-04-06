class InstagramService

  def initialize
    @_connection = Faraday.new(url: "https://api.instagram.com/v1")
  end

  def user_info(token)
    parse(connection.get('users/self', {access_token: token}))
  end

  def user_media(token)
    parse(connection.get('users/self/media/recent', {access_token: token}))
  end

  def post_media(token, post_id)
    parse(connection.get("media/#{post_id}", {access_token: token}))
  end

  private
    def connection
      @_connection
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
