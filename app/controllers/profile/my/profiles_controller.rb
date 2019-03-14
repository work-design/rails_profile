class Profile::My::ProfilesController < Profile::My::BaseController
  before_action :set_profile

  def show
    respond_to do |format|
      format.js
      format.html
      format.json { render json: @profile }
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update profile_params
        format.html { redirect_to my_profile_url, notice: 'Profile was successfully updated.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  private
  def set_profile
    @profile = current_user.profile || current_user.create_profile
  end

  def profile_params
    params.fetch(:profile, {}).permit(
      :real_name,
      :gender,
      :birthday_type,
      :birthday,
      :highest_education,
      :degree,
      :major
    )
  end

end
