class Profile::Admin::AreasController < Profile::Admin::BaseController
  before_action :set_area, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:name)
    @areas = Area.unscoped.default_where(q_params).order(id: :asc).page(params[:page])
  end

  def show
  end

  def new
    @area = Area.new
  end

  def edit
  end

  def create
    @area = Area.new area_params

    if @area.save
      redirect_to admin_areas_url
    else
      render action: 'new'
    end
  end

  def update
    if @area.update area_params
      redirect_to admin_areas_url
    else
      render action: 'edit'
    end
  end

  def destroy
    @area.destroy
    redirect_to admin_areas_url
  end

  private
  def set_area
    @area = Area.unscoped.find params[:id]
  end

  def area_params
    params.fetch(:area, {}).permit(
      :name,
      :popular,
      :published,
      :parent_ancestors
    )
  end

end
