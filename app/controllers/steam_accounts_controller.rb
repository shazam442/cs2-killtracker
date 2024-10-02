class SteamAccountsController < ApplicationController
  before_action :set_steam_account, only: %i[ show edit update destroy ]

  def index
    @steam_accounts = SteamAccount.all
  end

  def show
    respond_to do |format|
      format.html # Renders show.html.erb by default
      format.json { render json: @steam_account } # Renders JSON response
    end
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
  end

  def update
    if @steam_account.update(steam_account_params)
      redirect_to steam_account_path(@steam_account), notice: "Steam Account successfully updated"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @steam_account.destroy
    redirect_to root_url, status: :see_other
  end

  private

  def set_steam_account
    @steam_account = SteamAccount.find_by(id: params[:id]) || SteamAccount.find_by(steamid: params[:id])
  end

  def steam_account_params
    params.require(:steam_account).permit(:nickname, :steamid, :kills, :person_id)
  end
end
