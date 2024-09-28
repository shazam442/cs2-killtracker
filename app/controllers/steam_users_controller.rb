class SteamUsersController < ApplicationController
  def show
    render json: { data: "bonjour" }
  end
end
