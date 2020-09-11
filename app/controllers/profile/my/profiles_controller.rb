class Profile::My::ProfilesController < Profile::My::BaseController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def new
    @profile = current_user.profiles.build
    prepare_form
  end

  def create
    @profile = current_user.profiles.build(profile_params)
    if @profile.save
      redirect_to my_profiles_url
    else
      prepare_form
      render :new
    end
  end

  def show
  end

  def edit
    prepare_form
  end

  def update
    @profile.assign_attributes profile_params

    if @profile.save
      render 'update', locals: { return_to: mine_profile_url }
    else
      render :edit, locals: { model: @profile }, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private
  def set_profile
    @profile = current_user.profiles.find_or_create_by(default_params)
  end

  def prepare_form
    @accounts = current_user.accounts.confirmed
  end

  def profile_params
    p = params.fetch(:profile, {}).permit(
      :real_name,
      :nick_name,
      :gender,
      :birthday_type,
      :birthday,
      :note,
      :degree,
      :major,
      :identity,
      extra: {}
    )
    p.merge! default_form_params
  end

end
