class AllowedList < ApplicationRecord
  belongs_to :user

  def self.remove_expired_token
    delete_by("expires_at <= ?", Time.now)
  end
end
