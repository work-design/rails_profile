module Profiled
  class My::AddressesController < My::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}

      @addresses = current_user.addresses.includes(:area).default_where(q_params).page(params[:page])
      @address = current_user.addresses.build
    end

    def new
      @address = current_user.addresses.build
      r = QqMapHelper.ip '110.53.215.204' || request.remote_ip
      area_params = r['ad_info']
      if area_params
        area = Area.sure_find_full [area_params['province'], area_params['city'], area_params['district'].presence].compact
      else
        area = Area.new
      end
      @address.area = area
    end

    def create
      @address = current_user.addresses.build(address_params)
      #@address.role = 'principal'

      if @address.save
        render 'create'
      else
        render :new, locals: { model: @address }, status: :unprocessable_entity
      end
    end

    def wechat
      area = Area.sure_find [area_params['province_name'], area_params['city_name'], area_params['country_name']]
      cached_key = [area.id, address_params[:detail], address_params[:contact], address_params[:tel]].join(',')

      @address = current_user.addresses.find_or_initialize_by(cached_key: cached_key)
      @address.assign_attributes address_params
      @address.area = area
      @address.source = 'wechat'
      @address.save

      return_to = URI(params[:return_to])
      return_to.query = "address_id=#{@address.id}"
      render 'wechat', locals: { return_to: return_to.to_s }
    end

    def show
    end

    def join
      au = current_user.address_users.find_or_initialize_by(address_id: @address.id)
      au.save
      render 'show'
    end

    def edit
    end

    def update
      @address.assign_attributes(address_params)

      unless @address.save
        render :edit, locals: { model: @address }, status: :unprocessable_entity
      end
    end

    def destroy
      @address.destroy
    end

    private
    def set_address
      @address = Address.find(params[:id])
    end

    def area_params
      params.permit(
        'province_name',
        'city_name',
        'country_name'
      )
    end

    def address_params
      params.fetch(:address, {}).permit(
        :name,
        :contact,
        :tel,
        :detail,
        :post_code,
        :area_id,
        :area_ancestors
      )
    end

  end
end