class CreateMatchStatRecords < ActiveRecord::Migration[7.2]
  def change
    create_table :match_stat_records do |t|
      t.string :request_type
      t.integer :kills
      t.integer :previous_kills
      t.integer :assists
      t.integer :deaths
      t.integer :mvps
      t.integer :score
      t.datetime :timestamp, null: false
      t.references :steam_user, foreign_key: true, null:false

      t.timestamps
    end
  end
end
