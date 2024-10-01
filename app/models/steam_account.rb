class SteamAccount < ApplicationRecord
  has_many :match_stat_records
  has_many :killtracker_units
end
