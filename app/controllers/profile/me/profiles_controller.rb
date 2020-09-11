class Profile::Me::ProfilesController < Profile::Me::BaseController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]

  def show
  end

  def edit
  end

  def update
    @profile.assign_attributes profile_params

    unless @profile.save
      render :edit, locals: { model: @profile }, status: :unprocessable_entity
    end
  end

  def destroy
  end

  private
  def set_profile
    @profile = current_member.profile || current_member.create_profile
  end

  def profile_params
    params.fetch(:profile, {}).permit(
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
  end

end
