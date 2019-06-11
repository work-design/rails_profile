class Profile::Member::ProfilesController < Profile::Member::BaseController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  
  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @profile.update profile_params
        format.html { redirect_to my_profiles_url }
        format.js { redirect_to my_profiles_url }
        format.json { render :show }
      else
        format.html { render action: 'edit' }
      end
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
