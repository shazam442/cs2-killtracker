class SteamAccount < ApplicationRecord
  validates :steamid, presence: true, uniqueness: true
  validates :nickname, presence: true
  validates :kills, numericality: { only_integer: true }
  validates :person_id, uniqueness: true, allow_nil: true

  has_many :match_stat_records
  has_many :killtracker_units
  belongs_to :person
end
