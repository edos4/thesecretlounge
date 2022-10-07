require "application_system_test_case"

class MembersTest < ApplicationSystemTestCase
  setup do
    @member = members(:one)
  end

  test "visiting the index" do
    visit members_url
    assert_selector "h1", text: "Members"
  end

  test "creating a Member" do
    visit members_url
    click_on "New Member"

    fill_in "Address", with: @member.address
    fill_in "Beauty bank", with: @member.beauty_bank
    fill_in "Branch", with: @member.branch_id
    fill_in "Contact number", with: @member.contact_number
    fill_in "Email", with: @member.email
    fill_in "Expiry date", with: @member.expiry_date
    fill_in "Loyalty points", with: @member.loyalty_points
    fill_in "Membership card number", with: @member.membership_card_number
    fill_in "Name", with: @member.name
    fill_in "Slug", with: @member.slug
    click_on "Create Member"

    assert_text "Member was successfully created."
    click_on "Back"
  end

  test "updating a Member" do
    visit members_url
    click_on "Edit it", match: :first

    fill_in "Address", with: @member.address
    fill_in "Beauty bank", with: @member.beauty_bank
    fill_in "Branch", with: @member.branch_id
    fill_in "Contact number", with: @member.contact_number
    fill_in "Email", with: @member.email
    fill_in "Expiry date", with: @member.expiry_date
    fill_in "Loyalty points", with: @member.loyalty_points
    fill_in "Membership card number", with: @member.membership_card_number
    fill_in "Name", with: @member.name
    fill_in "Slug", with: @member.slug
    click_on "Update Member"

    assert_text "Member was successfully updated."
    click_on "Back"
  end

  test "destroying a Member" do
    visit members_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Member was successfully destroyed."
  end
end
