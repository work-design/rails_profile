module Profiled
  class Admin::ProfilesController < Admin::BaseController
    before_action :set_profile, only: [:show, :edit, :update, :user, :qrcode, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @profiles = Profile.default_where(q_params).page(params[:page])
    end

    def user
      @profile.init_user
    end

    def qrcode
      @profile.init_user
      @profile.account.qrcode
    end

    private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      [
        :real_name,
        :nick_name,
        :gender,
        :birthday_type,
        :birthday,
        :area_id,
        :address,
        :note,
        :resume,
        :avatar
      ]
    end

  end
end
