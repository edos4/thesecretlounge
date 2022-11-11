class Branch < ApplicationRecord
  has_many :members

  def expired_count
    self.members.where("expiry_date < ?", Time.zone.now).count
  end
end
