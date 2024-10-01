class SteamAccountsController < ApplicationController
  def show
    steam_account = SteamAccount.find_by(steamid: params[:steamid])

    render json: steam_account || { data: "NONE"}
  end
end
