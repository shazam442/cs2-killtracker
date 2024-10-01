class AddPersonReferenceToSteamAccounts < ActiveRecord::Migration[7.2]
  def change
    add_reference :steam_accounts, :person, null: true, foreign_key: true
  end
end
