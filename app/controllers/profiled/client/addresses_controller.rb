module Profiled
  class Client::AddressesController < My::AddressesController

    def index
      q_params = {
        member_organ_id: current_client.organ_id
      }

      @addresses = Address.includes(:area).default_where(q_params).order(id: :desc).page(params[:page])
    end


  end
end
