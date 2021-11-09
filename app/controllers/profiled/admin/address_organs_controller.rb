module Profiled
  class Admin::AddressOrgansController < Admin::BaseController
    before_action :set_new_address_organ, only: [:new]
    before_action :set_create_address_organ, only: [:create]

    def index
      @address_organs = current_organ.address_organs.includes(address: :area).page(params[:page])
    end

    private
    def set_new_address_organ
      @address_organ = current_organ.address_organs.build
      @address_organ.build_address
      @address_organ.address.area = Area.new
    end

    def set_create_address_organ
      @address_organ = current_organ.address_organs.build(address_organ_params)
    end

    def address_organ_params
      params.fetch(:address_organ, {}).permit(
        :state,
        :default,
        address_attributes: {}
      )
    end

  end
end
