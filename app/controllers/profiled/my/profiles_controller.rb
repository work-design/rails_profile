module Profiled
  class My::ProfilesController < My::BaseController
    before_action :set_profile, only: [:show, :edit, :update, :destroy, :qrcode]

    def qrcode
    end

    private
    def set_profile
      @profile = current_user.profiles.find_or_create_by(default_params)
    end

    def profile_params
      params.fetch(:profile, {}).permit(
        :real_name,
        :nick_name,
        :gender,
        :birthday_type,
        :birthday,
        :note,
        :degree,
        :major,
        :identity,
        extra: {}
      )
    end

  end
end
