class Person < ApplicationRecord
  has_one :steam_account, dependent: :destroy
  has_one :killtracker_unit

  def full_name
    self.first_name + ' ' + self.last_name
  end
end
