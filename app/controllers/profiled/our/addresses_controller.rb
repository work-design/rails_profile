module Profiled
  class Our::AddressesController < My::AddressesController

    def index
      @addresses = current_client.organ.addresses.includes(:area).order(id: :desc).page(params[:page])
    end

  end
end
