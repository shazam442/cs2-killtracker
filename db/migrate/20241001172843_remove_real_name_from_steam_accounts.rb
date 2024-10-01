class RemoveRealNameFromSteamAccounts < ActiveRecord::Migration[7.2]
  def change
    remove_column :steam_accounts, :real_name, :string
    add_reference :steam_accounts, :person, index: true
  end
end
