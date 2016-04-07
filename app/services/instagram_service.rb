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

  def following(token)
    parse(connection.get('users/self/follows', {access_token: token}))
  end

  def post_media(token, post_id)
    parse(connection.get("media/#{post_id}", {access_token: token}))
  end

  def create_comment(token, post_id, comment)
    connection.post("media/#{post_id}/comments", {access_token: token, text: comment})
  end

  def comments(token, post_id)
    parse(connection.get("media/#{post_id}/comments", {access_token: token}))
  end

  def following_media(token, user_id)
    parse(connection.get("users/#{user_id}/media/recent", {access_token: token}))
  end

  private
    def connection
      @_connection
    end

    def parse(response)
      JSON.parse(response.body, symbolize_names: true)
    end
end
