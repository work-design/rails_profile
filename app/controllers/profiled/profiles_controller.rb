module Profiled
  class ProfilesController < BaseController
    before_action :require_login
    before_action :set_profile, only: [:qrcode]

    def qrcode
      if current_user.organ_ids.include?(@profile.organ_id)
        redirect_to({ controller: 'serve/me/servings', action: 'qrcode', id: params[:id], host: @serving.service.organ.host }, allow_other_host: true)
      end
    end

    private
    def set_profile
      @profile = Profile.find params[:id]
    end

  end
end
