module Profiled
  class AreasController < BaseController

    def index
    end

    def search
      if params[:nation]
        @areas = Area.where(nation: params[:nation]).select(:province).distinct
        results = @areas.map { |x| { value: x.province, text: x.province, name: x.province } }
      elsif params[:province]
        @areas = Area.where(province: params[:province]).select(:city, :id).distinct
        results = @areas.map { |x| { value: x.id, text: x.city, name: x.city } }
      else
        results = []
      end

      render json: { values: results }
    end

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
