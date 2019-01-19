class StaticPagesController < ApplicationController

  def home
    @username = ""
    @photos = []

    if params[:search]
      @user_id = search_params[:user_id]

      unless valid_user?(@user_id)
        @user_id = Figaro.env.BASELINE_UID
        flash[:notice] = "We couldn't find the user you requested, view these photos instead while you try a new search.\n"
        flash[:notice] += "Make sure you are using the Flickr ID number, which is not the same as the username"
      end

      begin
        @photos = flickr.people.getPhotos(user_id: @user_id, extras: "url_m", per_page: 25)
        @username = flickr.people.getInfo(user_id: @photos.first.owner).username
      rescue
        raise
        flash[:notice] = "Invalid user"
        redirect_to root_path
      end
    end
  end

  private

    def search_params
      params.require(:search).permit(:user_id)
    end
end
