class Profile::My::ProfilesController < Profile::My::BaseController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  
  def index
    @profiles = current_user.profiles
  end
  
  def new
    @profile = current_user.profiles.build
  end
  
  def create
    @profile = current_user.profiles.build(profile_params)
    @profile.save
  end
  
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
    @profile = current_user.profiles.find params[:id]
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
      :major
    )
  end

end
