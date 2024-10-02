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
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @steam_account = SteamAccount.find(params[:id])
  end

  def update
    @steam_account = SteamAccount.find(params[:id])

    if @steam_account.update(steam_account_params)
      redirect_to steam_accounts_path, notice: "Steam Account successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def steam_account_params
    params.require(:steam_account).permit(:nickname, :steamid, :kills, :person_id)
  end
end
