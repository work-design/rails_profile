class Profile::Admin::AddressesController < Profile::Admin::BaseController
  before_action :set_addresses, only: [:index]
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
  end

  def new
    @address = Address.new(user_id: params[:user_id], kind: params[:kind], address_type: params[:address_type])
  end

  def create
    @address = Address.new(address_params)

    respond_to do |format|
      if @address.save
        format.html {
          redirect_to admin_addresses_url(user_id: @address.user_id), notice: 'Address was successfully created.'
        }
        format.js
        format.json { render json: @order, status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.js
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @address.update(address_params)
        format.html { redirect_to admin_addresses_url(user_id: @address.user_id), notice: 'Address was successfully updated.' }
        format.js
      else
        format.html { render :edit }
        format.js
      end
    end
  end

  def destroy
    @address.destroy
    respond_to do |format|
      format.html { redirect_to admin_addresses_url(user_id: @address.user_id), notice: 'Address was successfully destroyed.' }
      format.js
    end
  end

  private
  def set_addresses
    if params[:user_id]
      @addresses = Address.includes(:area).where(user_id: params[:user_id])
    elsif params[:buyer_id]
      @addresses = Address.includes(:area).where(buyer_id: params[:buyer_id])
    else
      @addresses = Address.none
    end
  end

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.fetch(:address, {}).permit! #(:user_id, :buyer_id, :area_id, :kind, :contact_person, :tel, :address)
  end

end
