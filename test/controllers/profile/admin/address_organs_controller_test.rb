require 'test_helper'
class Profile::Admin::AddressOrgansControllerTest < ActionDispatch::IntegrationTest

  setup do
    @address_organ = address_organs(:one)
  end

  test 'index ok' do
    get url_for(controller: 'profile/admin/address_organs')

    assert_response :success
  end

  test 'new ok' do
    get url_for(controller: 'profile/admin/address_organs')

    assert_response :success
  end

  test 'create ok' do
    assert_difference('AddressOrgan.count') do
      post(
        url_for(controller: 'profile/admin/address_organs', action: 'create'),
        params: { address_organ: { area_id: @profile_admin_address_organ.area_id, contact: @profile_admin_address_organ.contact, default: @profile_admin_address_organ.default, detail: @profile_admin_address_organ.detail, kind: @profile_admin_address_organ.kind, post_code: @profile_admin_address_organ.post_code, tel: @profile_admin_address_organ.tel } },
        as: :turbo_stream
      )
    end

    assert_response :success
  end

  test 'show ok' do
    get url_for(controller: 'profile/admin/address_organs', action: 'show', id: @address_organ.id)

    assert_response :success
  end

  test 'edit ok' do
    get url_for(controller: 'profile/admin/address_organs', action: 'edit', id: @address_organ.id)

    assert_response :success
  end

  test 'update ok' do
    patch(
      url_for(controller: 'profile/admin/address_organs', action: 'update', id: @address_organ.id),
      params: { address_organ: { area_id: @profile_admin_address_organ.area_id, contact: @profile_admin_address_organ.contact, default: @profile_admin_address_organ.default, detail: @profile_admin_address_organ.detail, kind: @profile_admin_address_organ.kind, post_code: @profile_admin_address_organ.post_code, tel: @profile_admin_address_organ.tel } },
      as: :turbo_stream
    )

    assert_response :success
  end

  test 'destroy ok' do
    assert_difference('AddressOrgan.count', -1) do
      delete url_for(controller: 'profile/admin/address_organs', action: 'destroy', id: @address_organ.id), as: :turbo_stream
    end

    assert_response :success
  end

end
