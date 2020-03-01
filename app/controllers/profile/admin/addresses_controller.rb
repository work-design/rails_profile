class Profile::Admin::AddressesController < Profile::Admin::BaseController
  before_action :set_address, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit('address_users.user_id')

    @addresses = Address.includes(:area).default_where(q_params).page(params[:page])
  end

  def new
    @address = Address.new(user_id: params[:user_id], kind: params[:kind], address_type: params[:address_type])
  end

  def create
    @address = Address.new(address_params)

    unless @address.save
      render :new, locals: { model: @address }, status: :unprocessable_entity
    end
  end

  def show
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

  def address_params
    params.fetch(:address, {}).permit! #(:user_id, :buyer_id, :area_id, :kind, :contact_person, :tel, :address)
  end

end
