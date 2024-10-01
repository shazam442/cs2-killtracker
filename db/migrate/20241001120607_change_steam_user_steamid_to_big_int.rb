class ChangeSteamUserSteamidToBigInt < ActiveRecord::Migration[7.2]
  def change
    change_column :steam_users, :steamid, :bigint
  end
end
