module Profiled
  class AreasController < BaseController

    def index
    end

    # for weui.js
    def list
      values = Profiled::Area.list(value_name: 'value', label_name: 'label')
      render json: { values: values }
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
end
