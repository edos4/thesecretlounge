json.extract! member, :id, :name, :email, :contact_number, :address, :branch_id, :slug, :membership_card_number, :expiry_date, :beauty_bank, :loyalty_points, :created_at, :updated_at
json.url member_url(member, format: :json)
