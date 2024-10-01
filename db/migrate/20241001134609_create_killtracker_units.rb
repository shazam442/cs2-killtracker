class CreateKilltrackerUnits < ActiveRecord::Migration[7.2]
  def change
    create_table :killtracker_units do |t|
      t.references :person, null: false, foreign_key: true
      t.references :tracked_steam_account, foreign_key: { to_table: :steam_accounts }

      t.timestamps
    end
  end
end
