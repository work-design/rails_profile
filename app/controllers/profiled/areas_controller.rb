module Profiled
  class AreasController < BaseController

    def index
    end

    # for weui.js
    def list
      values = Area.list(value_name: 'value', label_name: 'label')

      if params[:area_id]
        area = Area.find params[:area_id]
        default = area.parent_ancestors.values + [area.id]
      else
        default = []
      end

      render json: { values: values, default: default }
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
