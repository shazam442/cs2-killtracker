class CreateSteamAccounts < ActiveRecord::Migration[7.2]
  def change
    create_table :people do |t|
      t.string :first_name, null: true
      t.string :last_name, null: true
      t.string :email, null: true

      t.timestamps
    end

    create_table :steam_accounts do |t|
      t.string :nickname, null: false
      t.bigint :steamid, null: false
      t.integer :kills, null: false, default: 0

      t.timestamps
    end

    create_table :killtracker_units do |t|
      t.references :person, null: false, foreign_key: true
      t.references :tracked_steam_account, null: true, foreign_key: { to_table: :steam_accounts }

      t.timestamps
    end

    create_table :match_stat_records do |t|
      t.string :request_type
      t.integer :kills
      t.integer :previous_kills
      t.integer :assists
      t.integer :deaths
      t.integer :mvps
      t.integer :score
      t.datetime :timestamp, null: false
      t.references :steam_account, foreign_key: true, null: false

      t.timestamps
    end

    add_index :steam_accounts, :steamid, unique: true
  end
end
