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

    if @address.save
      render 'create', locals: { return_to: my_addresses_url }
    else
      render :new, locals: { model: @address }, status: :unprocessable_entity
    end
  end

  def wechat
    @address = current_user.addresses.build(address_params)
    area = Area.sure_find [area_params['provinceName'], area_params['cityName'], area_params['countryName']]
    @address.area = area

    if @address.save
      render 'create', locals: { return_to: my_addresses_url }
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
