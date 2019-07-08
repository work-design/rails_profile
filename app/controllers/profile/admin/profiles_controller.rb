class Profile::Admin::ProfilesController < Profile::Admin::BaseController
  before_action :set_profile, only: [:show, :edit, :update, :user, :qrcode, :destroy]

  def index
    @profiles = Profile.page(params[:page])
  end

  def new
    @profile = Profile.new
  end

  def create
    @profile = Profile.new(profile_params)

    respond_to do |format|
      if @profile.save
        format.html.phone
        format.html { redirect_to admin_profiles_url }
        format.js { redirect_back fallback_location: admin_profiles_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: admin_profiles_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @profile.assign_attributes(profile_params)

    respond_to do |format|
      if @profile.save
        format.html.phone
        format.html { redirect_to admin_profiles_url }
        format.js
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js
        format.json { render :show }
      end
    end
  end
  
  def user
    @profile.init_user
  end
  
  def qrcode
    @profile.init_user
    @profile.account.qrcode
  end

  def destroy
    @profile.destroy
    redirect_to admin_profiles_url
  end

  private
  def set_profile
    @profile = Profile.find(params[:id])
  end

  def profile_params
    params.fetch(:profile, {}).permit(
      :real_name,
      :nick_name,
      :gender,
      :birthday_type,
      :birthday,
      :area_id,
      :address,
      :note,
      :resume,
      :avatar
    )
  end

end
