require "application_system_test_case"

class ProfilesTest < ApplicationSystemTestCase
  setup do
    @profile_admin_profile = profile_admin_profiles(:one)
  end

  test "visiting the index" do
    visit profile_admin_profiles_url
    assert_selector "h1", text: "Profiles"
  end

  test "creating a Profile" do
    visit profile_admin_profiles_url
    click_on "New Profile"

    fill_in "Address", with: @profile_admin_profile.address
    fill_in "Area", with: @profile_admin_profile.area_id
    fill_in "Birthday", with: @profile_admin_profile.birthday
    fill_in "Birthday type", with: @profile_admin_profile.birthday_type
    fill_in "Extra", with: @profile_admin_profile.extra
    fill_in "Gender", with: @profile_admin_profile.gender
    fill_in "Nick name", with: @profile_admin_profile.nick_name
    fill_in "Note", with: @profile_admin_profile.note
    fill_in "Real name", with: @profile_admin_profile.real_name
    click_on "Create Profile"

    assert_text "Profile was successfully created"
    click_on "Back"
  end

  test "updating a Profile" do
    visit profile_admin_profiles_url
    click_on "Edit", match: :first

    fill_in "Address", with: @profile_admin_profile.address
    fill_in "Area", with: @profile_admin_profile.area_id
    fill_in "Birthday", with: @profile_admin_profile.birthday
    fill_in "Birthday type", with: @profile_admin_profile.birthday_type
    fill_in "Extra", with: @profile_admin_profile.extra
    fill_in "Gender", with: @profile_admin_profile.gender
    fill_in "Nick name", with: @profile_admin_profile.nick_name
    fill_in "Note", with: @profile_admin_profile.note
    fill_in "Real name", with: @profile_admin_profile.real_name
    click_on "Update Profile"

    assert_text "Profile was successfully updated"
    click_on "Back"
  end

  test "destroying a Profile" do
    visit profile_admin_profiles_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Profile was successfully destroyed"
  end
end
