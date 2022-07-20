require "application_system_test_case"

class CitizensTest < ApplicationSystemTestCase
  setup do
    @citizen = citizens(:one)
  end

  test "visiting the index" do
    visit citizens_url
    assert_selector "h1", text: "Citizens"
  end

  test "creating a Citizen" do
    visit citizens_url
    click_on "New Citizen"

    fill_in "Address", with: @citizen.address
    fill_in "Mobile number", with: @citizen.mobile_number
    fill_in "Name", with: @citizen.name
    click_on "Create Citizen"

    assert_text "Citizen was successfully created."
    click_on "Back"
  end

  test "updating a Citizen" do
    visit citizens_url
    click_on "Edit it", match: :first

    fill_in "Address", with: @citizen.address
    fill_in "Mobile number", with: @citizen.mobile_number
    fill_in "Name", with: @citizen.name
    click_on "Update Citizen"

    assert_text "Citizen was successfully updated."
    click_on "Back"
  end

  test "destroying a Citizen" do
    visit citizens_url
    page.accept_confirm do
      click_on "Destroy it", match: :first
    end

    assert_text "Citizen was successfully destroyed."
  end
end
