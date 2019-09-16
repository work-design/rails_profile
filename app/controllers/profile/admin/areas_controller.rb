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

    unless @area.save
      render :new, locals: { model: @area }, status: :unprocessable_entity
    end
  end

  def update
    @area.assign_attributes area_params

    unless @area.save
      render :new, locals: { model: @area }, status: :unprocessable_entity
    end
  end

  def destroy
    @area.destroy
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
