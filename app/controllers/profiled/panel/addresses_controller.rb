module Profiled
  class Panel::AddressesController < Panel::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit('user_id')

      @addresses = Address.includes(:area, :station, account: :user).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def search
      q_params = {}
      q_params.merge! params.permit('name-like')

      @stations = Ship::Station.default_where(q_params)
    end

    private
    def set_address
      @address = Address.find(params[:id])
    end

    def address_params
      params.fetch(:address, {}).permit(*address_permit_params)
    end

    def address_permit_params
      [
        :contact,
        :tel,
        :detail,
        :area_id,
        :station_id,
        :principal,
        :area_ancestors
      ]
    end

  end
end
