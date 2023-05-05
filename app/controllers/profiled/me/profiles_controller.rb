module Profiled
  class Me::ProfilesController < Me::BaseController
    before_action :set_profile, only: [:show, :qrcode, :edit, :update, :destroy]

    def show
    end

    def qrcode
    end

    private
    def set_profile
      @profile = current_member.profile || current_member.create_profile
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
