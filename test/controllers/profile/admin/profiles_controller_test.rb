require 'test_helper'

class Profile::Admin::ProfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profile_admin_profile = create profile_admin_profiles
  end

  test 'index ok' do
    get admin_profiles_url
    assert_response :success
  end

  test 'new ok' do
    get new_admin_profile_url
    assert_response :success
  end

  test 'create ok' do
    assert_difference('Profile.count') do
      post admin_profiles_url, params: { #{singular_table_name}: { #{attributes_string} } }
    end

    assert_redirected_to profile_admin_profile_url(Profile.last)
  end

  test 'show ok' do
    get admin_profile_url(@profile_admin_profile)
    assert_response :success
  end

  test 'edit ok' do
    get edit_admin_profile_url(@profile_admin_profile)
    assert_response :success
  end

  test 'update ok' do
    patch admin_profile_url(@profile_admin_profile), params: { #{singular_table_name}: { #{attributes_string} } }
    assert_redirected_to profile_admin_profile_url(@#{singular_table_name})
  end

  test 'destroy ok' do
    assert_difference('Profile.count', -1) do
      delete admin_profile_url(@profile_admin_profile)
    end

    assert_redirected_to admin_profiles_url
  end
end
