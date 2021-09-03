module Profiled
  class Panel::AreasController < Panel::BaseController
    before_action :set_area, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:name)

      @areas = Area.unscoped.default_where(q_params).order(id: :asc).page(params[:page])
    end

    private
    def set_area
      @area = Area.unscoped.find params[:id]
    end

    def area_permit_params
      [
        :name,
        :popular,
        :published,
        :parent_ancestors
      ]
    end

  end
end
