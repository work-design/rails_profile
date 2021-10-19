require "application_system_test_case"

class AddressOrgansTest < ApplicationSystemTestCase
  setup do
    @profile_admin_address_organ = profile_admin_address_organs(:one)
  end

  test "visiting the index" do
    visit profile_admin_address_organs_url
    assert_selector "h1", text: "Address Organs"
  end

  test "should create Address organ" do
    visit profile_admin_address_organs_url
    click_on "New Address Organ"

    fill_in "Area", with: @profile_admin_address_organ.area_id
    fill_in "Contact", with: @profile_admin_address_organ.contact
    fill_in "Default", with: @profile_admin_address_organ.default
    fill_in "Detail", with: @profile_admin_address_organ.detail
    fill_in "Kind", with: @profile_admin_address_organ.kind
    fill_in "Post code", with: @profile_admin_address_organ.post_code
    fill_in "Tel", with: @profile_admin_address_organ.tel
    click_on "Create Address organ"

    assert_text "Address organ was successfully created"
    click_on "Back"
  end

  test "should update Address organ" do
    visit profile_admin_address_organs_url
    click_on "Edit", match: :first

    fill_in "Area", with: @profile_admin_address_organ.area_id
    fill_in "Contact", with: @profile_admin_address_organ.contact
    fill_in "Default", with: @profile_admin_address_organ.default
    fill_in "Detail", with: @profile_admin_address_organ.detail
    fill_in "Kind", with: @profile_admin_address_organ.kind
    fill_in "Post code", with: @profile_admin_address_organ.post_code
    fill_in "Tel", with: @profile_admin_address_organ.tel
    click_on "Update Address organ"

    assert_text "Address organ was successfully updated"
    click_on "Back"
  end

  test "should destroy Address organ" do
    visit profile_admin_address_organs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Address organ was successfully destroyed"
  end
end
