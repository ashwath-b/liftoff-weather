class StatsController < ApplicationController
  def index
    if params["city_name"].nil? || (lat, long = Geocoder.coordinates(params["city_name"])).nil?
      lat, long = 12.9715987, 77.5945627
      @city = "Bengaluru"
    else
      @city = params["city_name"]
    end
    forecast = ForecastIO.forecast(lat, long)
    @hourly_data_gchart = forecast['hourly']['data'].map{|a| [a['time'], a['temperature']]}
    @hourly_data = forecast['hourly']['data'].map{|a| [Time.at(a['time']).to_datetime, a['temperature']]}
    @min_max = []
    @hourly_data.group_by{|e| e[0].strftime('%d/%m/%y')}.each do |k,v|
      sort_day = v.sort_by{|e| [e[0].strftime('%d/%m/%Y'), e[1]]}
      @min_max << sort_day[0]
      @min_max << sort_day.last
    end
    @sorted = @hourly_data.sort_by{|e| [e[0].strftime('%d/%m/%Y'), e[1]]}
  end
end
