module Profiled
  class Admin::ProfilesController < Admin::BaseController
    before_action :set_profile, only: [:show, :edit, :update, :user, :qrcode, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params

      @profiles = Profile.default_where(q_params).page(params[:page])
    end

    def new
      @profile = Profile.new
    end

    def create
      @profile = Profile.new(profile_params)

      unless @profile.save
        render :new, locals: { model: @profile }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @profile.assign_attributes(profile_params)

      unless @profile.save
        render :edit, locals: { model: @profile }, status: :unprocessable_entity
      end
    end

    def user
      @profile.init_user
    end

    def qrcode
      @profile.init_user
      @profile.account.qrcode
    end

    def destroy
      @profile.destroy
    end

    private
    def set_profile
      @profile = Profile.find(params[:id])
    end

    def profile_params
      params.fetch(:profile, {}).permit(
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
      )
    end

  end
end
