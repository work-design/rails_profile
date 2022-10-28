module Profiled
  class ProfilesController < BaseController
    before_action :require_user
    before_action :set_profile, only: [:qrcode]

    def qrcode
      if current_user.organ_ids.include?(@profile.organ_id)
        redirect_to({ controller: 'crm/me/maintains', action: 'client', client_id: params[:id], host: @profile.organ.host }, allow_other_host: true)
      end
    end

    private
    def set_profile
      @profile = Profile.find params[:id]
    end

  end
end
