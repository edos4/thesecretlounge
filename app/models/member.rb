class Member < ApplicationRecord
  belongs_to :branch
  has_many :member_services
  has_many :services, through: :member_services
end
