class KilltrackerUnit < ApplicationRecord
  belongs_to :person
  belongs_to :tracked_steam_account, class_name: "SteamAccount", foreign_key: "steam_account_id"
end
