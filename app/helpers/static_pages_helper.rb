require 'flickraw'

module StaticPagesHelper

  def valid_user?(user_id)
    begin
      flickr.people.getPhotos(api_key: Figaro.env.FLICKRAW_API_KEY, user_id: user_id, extras: "url_m", per_page: 1)
    rescue
      false
    end
  end

end
