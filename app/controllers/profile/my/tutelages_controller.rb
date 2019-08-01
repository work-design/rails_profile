class Profile::My::TutelagesController < Profile::My::BaseController
  before_action :set_tutelage, only: [:show, :edit, :update, :destroy]

  def index
    @tutelages = current_user.proteges.includes(:pupil).page(params[:page])
  end

  def new
    @tutelage = current_user.proteges.build
    @tutelage.build_pupil
  end

  def create
    @tutelage = current_user.proteges.build(protege_params)

    if @tutelage.save
      redirect_to my_tutelages_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @tutelage.update(protege_params)
      redirect_to my_tutelages_url
    else
      render :edit
    end
  end

  def destroy
    @tutelage.destroy
    redirect_to my_tutelages_url
  end

  private
  def set_tutelage
    @tutelage = Tutelage.find(params[:id])
  end

  def pupil_params
    params.fetch(:pupil, {}).permit(
      :real_name,
      :nick_name,
      :birthday_type,
      :birthday,
      :gender,
      :note,
      :avatar,
      tutelages_attributes: {}
    )
  end

  def protege_params
    params.fetch(:tutelage, {}).permit(
      :relation,
      pupil_attributes: {}
    )
  end

end
