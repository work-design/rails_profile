module Profiled
  class Admin::AddressesController < Admin::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit('address_users.user_id')

      @addresses = current_oragn.addresses.includes(:area).default_where(q_params).page(params[:page])
    end

    def new
      @address = Address.new params.permit(*address_permit_params)
      @address.area ||= Area.new
    end

    private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_permit_params
      [
        :user_id,
        :kind,
        :contact_person,
        :tel,
        :address,
        :area_ancestors
      ]
    end

  end
end
