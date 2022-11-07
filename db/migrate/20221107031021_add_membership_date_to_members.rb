class AddMembershipDateToMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :members, :membership_date, :date
  end
end
