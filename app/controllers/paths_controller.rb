class PathsController < ApplicationController
  before_filter :validate_params
  before_filter :load_station

  def shortest
    render status: 200, json: {
      shortest: Station.route_between(@station_1, @station_2)
                       .map {|route| route['name'] }
                       .select{|name| true if name.present? }
    }.to_json
  end

  def approximate_time
    render status: 200, json: { approximate_time_in_minutes: Station.approximate_time(@station_1, @station_2).to_json }
  end

  private
  def load_station
    @station_1 = Station.find_by_number(params[:station_1])
    @station_2 = Station.find_by_number(params[:station_2])
    render status: 400 unless @station_1.present? && @station_2.present?
  end

  def validate_params
    render status: 400 unless params.include?(:station_1) && params.include?(:station_2)
  end
end
