module Profiled
  class My::AddressUsersController < My::BaseController
    before_action :set_address
    before_action :set_new_address_user, only: [:new, :create]

    def index
      @address_users = @address.address_users.page(params[:page])
    end

    private
    def set_new_address_user
      @address_user = @address.address_users.build(**params.permit(:user_id))
    end

    def set_address
      @address = Address.find(params[:address_id])
    end

    def address_user_params
      params.fetch(:address_user, {}).permit(
        :user_id,
        :state
      )
    end

  end
end
