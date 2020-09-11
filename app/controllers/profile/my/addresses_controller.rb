class Profile::My::AddressesController < Profile::My::BaseController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    @addresses = current_user.addresses.includes(:area).default_where(q_params).page(params[:page])
  end

  def new
    @address = current_user.addresses.build
  end

  def create
    @address = current_user.addresses.build(address_params)
    @address.role = 'principal'

    if @address.save
      render 'create', locals: { return_to: my_addresses_url }
    else
      render :new, locals: { model: @address }, status: :unprocessable_entity
    end
  end

  def wechat
    area = Area.sure_find [area_params['provinceName'], area_params['cityName'], area_params['countryName']]
    cached_key = [area.id, address_params[:detail], address_params[:contact], address_params[:tel]].join(',')

    @address = current_user.addresses.find_or_initialize_by(cached_key: cached_key)
    @address.assign_attributes address_params
    @address.area = area
    @address.source = 'wechat'

    if @address.save
      return_to = URI(params[:return_to])
      return_to.query = "address_id=#{@address.id}"
      render 'create', locals: { return_to: return_to.to_s || my_addresses_url }
    else
      render :new, locals: { model: @address }, status: :unprocessable_entity
    end
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
    params.permit('provinceName', 'cityName', 'countryName')
  end

  def address_params
    params.fetch(:address, {}).permit(
      :area_id,
      :name,
      :contact,
      :tel,
      :detail,
      :post_code
    )
  end

end
