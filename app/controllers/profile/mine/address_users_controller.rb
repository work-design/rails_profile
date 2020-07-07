class Profile::Mine::AddressUsersController < Profile::Mine::BaseController
  before_action :set_address

  def index
    @address_users = @address.address_users.page(params[:page])
  end

  def new
    @address_user = @address.address_users.build
  end

  def create
    @address_user = @address.address_users.build(user_id: user.id)

    if @address_user.save
      render 'create', locals: { return_to: my_rallies_url }
    else
      render :new, locals: { model: @address_user }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @address_user.assign_attributes(address_user_params)

    unless @address_user.save
      render :edit, locals: { model: @address_user }, status: :unprocessable_entity
    end
  end

  def destroy
    @address_user.destroy
  end

  private
  def set_address
    @address = Address.find(params[:address_id])
  end

  def address_user_params
    params.fetch(:address_user, {}).permit(
      :user_id,
      :state
    )
  end

end
