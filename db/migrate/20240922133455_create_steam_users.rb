class CreateSteamUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :steam_users do |t|
      t.string :real_name, null: false
      t.string :nickname, null: false
      t.integer :steamid, null: false
      t.integer :kills, null: false, default: 0

      t.timestamps
    end

    add_index :steam_users, :steamid, unique: true
  end
end
