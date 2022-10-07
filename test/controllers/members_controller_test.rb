require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = members(:one)
  end

  test "should get index" do
    get members_url
    assert_response :success
  end

  test "should get new" do
    get new_member_url
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post members_url, params: { member: { address: @member.address, beauty_bank: @member.beauty_bank, branch_id: @member.branch_id, contact_number: @member.contact_number, email: @member.email, expiry_date: @member.expiry_date, loyalty_points: @member.loyalty_points, membership_card_number: @member.membership_card_number, name: @member.name, slug: @member.slug } }
    end

    assert_redirected_to member_url(Member.last)
  end

  test "should show member" do
    get member_url(@member)
    assert_response :success
  end

  test "should get edit" do
    get edit_member_url(@member)
    assert_response :success
  end

  test "should update member" do
    patch member_url(@member), params: { member: { address: @member.address, beauty_bank: @member.beauty_bank, branch_id: @member.branch_id, contact_number: @member.contact_number, email: @member.email, expiry_date: @member.expiry_date, loyalty_points: @member.loyalty_points, membership_card_number: @member.membership_card_number, name: @member.name, slug: @member.slug } }
    assert_redirected_to member_url(@member)
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete member_url(@member)
    end

    assert_redirected_to members_url
  end
end
