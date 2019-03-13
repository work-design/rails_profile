class Trade::My::AddressesController < Trade::My::BaseController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
    @addresses = current_buyer.addresses.includes(:area).page(params[:page])
  end

  def show
  end

  def new
    @address = current_buyer.addresses.build
  end

  def edit
  end

  def create
    @address = current_buyer.addresses.build(address_params)

    if @address.save
      redirect_to my_addresses_url, notice: 'Address was successfully created.'
    else
      render :new
    end
  end

  def update
    if @address.update(address_params)
      redirect_to my_addresses_url, notice: 'Address was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @address.destroy
    redirect_to my_addresses_url, notice: 'Address was successfully destroyed.'
  end

  private
  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.fetch(:address, {}).permit(
      :area_id,
      :contact_person,
      :tel,
      :address
    )
  end

end
