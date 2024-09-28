class SteamUsersController < ApplicationController
  def show
    steam_user = SteamUser.find_by(steamid: params[:steamid])

    render json: steam_user || { data: "NONE"}
  end
end
