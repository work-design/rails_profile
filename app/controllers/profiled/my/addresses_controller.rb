module Profiled
  class My::AddressesController < My::BaseController
    before_action :set_address, only: [:show, :edit, :update, :destroy]
    before_action :set_new_address, only: [:new, :create, :order_new, :order_create]

    def index
      q_params = {}

      @addresses = current_user.addresses.includes(:area).default_where(q_params).order(id: :desc).page(params[:page])
      @address = current_user.addresses.build
    end

    def list
    end

    def new
      r = QqMapHelper.ip '110.53.215.204' || request.remote_ip
      area_params = r['ad_info']
      if area_params
        area = Area.sure_find_full [area_params['province'], area_params['city'], area_params['district'].presence].compact
      else
        area = Area.new
      end
      @address.area = area
    end

    def order_new
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
    end

    def order_create
    end

    def fork
      @address = current_user.addresses.build
      @address.contact = params[:userName]
      @address.tel = params[:telNumber]
      @address.detail = params[:detailInfo]
      @address.post_code = params[:postalCode]
    end

    def wechat
      # uniq 解决['上海市', '上海市'] 的问题
      area = Area.sure_find [params['provinceName'], params['cityName'], params['countyName']].reject(&:blank?).uniq
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

    def program
      area = Area.sure_find [params['provinceName'], params['cityName'], params['countyName']].reject(&:blank?).uniq
      cached_key = [area.id, params['detailInfo'], params['userName'], params['telNumber']].join(',')

      @address = current_user.addresses.find_or_initialize_by(cached_key: cached_key)
      @address.contact = params['userName']
      @address.tel = params['telNumber']
      @address.detail = params['detailInfo']
      @address.post_code = params[:postalCode]
      @address.area = area
      @address.source = 'program'
      @address.save

      render json: { id: @address.id }
    end

    def join
      au = current_user.address_users.find_or_initialize_by(address_id: @address.id)
      au.save
      render 'show'
    end

    private
    def set_address
      @address = Address.find(params[:id])
    end

    def set_new_address
      @address = current_user.addresses.build
    end

    def address_params
      params.fetch(:address, {}).permit(
        :name,
        :contact,
        :tel,
        :detail,
        :post_code,
        :area_id,
        :area_ancestors,
        :principal
      )
    end

  end
end
