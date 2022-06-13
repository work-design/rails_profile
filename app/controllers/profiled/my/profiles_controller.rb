module Profiled
  class My::ProfilesController < My::BaseController
    before_action :set_profile, only: [:show, :edit, :update, :destroy]
    before_action :set_accounts, only: [:edit, :update]

    def new
      @profile = current_user.profiles.build
      prepare_form
    end

    def create
      @profile = current_user.profiles.build(profile_params)

      if @profile.save
        render 'create'
      else
        prepare_form
        render :new
      end
    end

    private
    def set_profile
      @profile = current_user.profiles.find_or_create_by(default_params)
    end

    def set_accounts
      @accounts = current_user.accounts.confirmed
    end

    def profile_params
      p = params.fetch(:profile, {}).permit(
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
      p.merge! default_form_params
    end

  end
end
