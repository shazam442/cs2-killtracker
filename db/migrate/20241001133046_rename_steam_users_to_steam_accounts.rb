class RenameSteamUsersToSteamAccounts < ActiveRecord::Migration[7.2]
  def change
    rename_table :steam_users, :steam_accounts
    rename_column :match_stat_records, :steam_user_id, :steam_account_id
  end
end
