class Person < ApplicationRecord
  has_one :steam_account
  has_one :killtracker_unit
end
