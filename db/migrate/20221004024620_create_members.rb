class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :name
      t.string :email
      t.string :contact_number
      t.string :address
      t.integer :branch_id
      t.string :slug
      t.string :membership_card_number
      t.date :expiry_date
      t.integer :beauty_bank
      t.integer :loyalty_points

      t.timestamps
    end
  end
end
