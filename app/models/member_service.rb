class MemberService < ApplicationRecord
  belongs_to :member
  belongs_to :service
end
