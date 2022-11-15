class Service < ApplicationRecord
  has_many :member_services
  has_many :members, through: :member_services
end
