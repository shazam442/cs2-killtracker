class SteamAccountsController < ApplicationController
  def index
    @steam_accounts = SteamAccount.all
  end

  def show
    steam_account = SteamAccount.find_by(steamid: params[:steamid]) || SteamAccount.find_by(id: params[:id])
    render json: steam_account || { data: "NONE"}
  end

  def new
    @steam_account = SteamAccount.new
  end

  def create
    @steam_account = SteamAccount.new steam_account_params


    if @steam_account.save
      redirect_to @steam_account, notice: 'Steam Account was successfully created'
    else
      Rails.logger.debug @steam_account.errors.full_messages
      Rails.logger.debug @steam_account.errors.any?
      render :new
    end
  end

  private

  def steam_account_params
    params.require(:steam_account).permit(:nickname, :steamid, :kills)
  end
end
