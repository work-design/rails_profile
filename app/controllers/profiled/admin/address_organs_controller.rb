module Profiled
  class Admin::AddressOrgansController < Admin::BaseController
    before_action :set_new_address_user, only: [:new, :create]

    def index
      @address_organs = current_organ.address_organs.includes(address: :area).page(params[:page])
    end

    private
    def set_new_address_user
      @address_user = @address.address_users.build(**params.permit(:user_id))
    end

    def address_user_params
      params.fetch(:address_user, {}).permit(
        :user_id,
        :state
      )
    end

  end
end
