ForecastIO.configure do |configuration|
  configuration.api_key = '8a90e43822302baed1192cc88da74c7f'
  configuration.default_params = {extend: 'hourly', exclude: 'minutely,currently', units: 'auto'}
end
