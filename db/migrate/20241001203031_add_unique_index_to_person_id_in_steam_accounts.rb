class AddUniqueIndexToPersonIdInSteamAccounts < ActiveRecord::Migration[7.2]
  def change
    remove_index :steam_accounts, :person_id

    add_index :steam_accounts, :person_id, unique: true
  end
end
