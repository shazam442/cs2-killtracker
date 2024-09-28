class MatchStatRecord < ApplicationRecord
  belongs_to :steam_user, optional: false
  before_save :set_type, :set_previous_kills

  private

  def set_previous_kills
    return if previous_kills
    # Find the most recent match_stat_record of type 'event' for the same user
    last_event_record = steam_user.match_stat_records
                                   .where(request_type: 'event')
                                   .order(timestamp: :desc)
                                   .first

    # If such a record exists, set previous_kills to the kills of that record
    self.previous_kills = last_event_record ? last_event_record.kills : nil
  end

  def set_type
    # Find the most recent record for the same steam_user
    last_record = steam_user.match_stat_records.order(timestamp: :desc).first

    # Check if the last record exists and if all fields match
    if last_record &&
       last_record.kills == kills &&
       last_record.assists == assists &&
       last_record.deaths == deaths &&
       last_record.mvps == mvps &&
       last_record.score == score

      # If all values are the same, set the type to "heartbeat"
      self.request_type = "heartbeat_or_other"
    else
      self.request_type = "event"
    end
  end
end
