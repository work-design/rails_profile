require 'test_helper'
module Profiled
  class Admin::ProfilesControllerTest < ActionDispatch::IntegrationTest
    setup do
      @profile = profiled_profiles(:one)
    end

    test 'index ok' do
      get url_for(controller: 'profiled/admin/profiles')
      assert_response :success
    end

    test 'new ok' do
      get url_for(controller: 'profiled/admin/profiles', action: 'new')
      assert_response :success
    end

    test 'create ok' do
      assert_difference('Profiled::Profile.count') do
        post(
          url_for(controller: 'profiled/admin/profiles', action: 'create'),
          params: { profile: { nick_name: 'xx' } },
          as: :turbo_stream
        )
      end

      assert_response :success
    end

    test 'show ok' do
      get url_for(controller: 'profiled/admin/profiles', action: 'show', id: @profile.id)
      assert_response :success
    end

    test 'edit ok' do
      get url_for(controller: 'profiled/admin/profiles', action: 'edit', id: @profile.id)
      assert_response :success
    end

    test 'update ok' do
      patch(
        url_for(controller: 'profiled/admin/profiles', action: 'update', id: @profile.id),
        params: { profile: { nick_name: 'xx' } },
        as: :turbo_stream
      )
      @profile.reload

      assert_equal 'xx', @profile.nick_name
      assert_response :success
    end

    test 'destroy ok' do
      assert_difference('Profiled::Profile.count', -1) do
        delete url_for(controller: 'profiled/admin/profiles', action: 'destroy', id: @profile.id), as: :turbo_stream
      end

      assert_response :success
    end
  end
end
