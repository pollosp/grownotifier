require 'faraday'
require 'faraday_middleware'
class GetMetrics
  def initialize (init_date, end_date,sensor, app_id, host_id,api_key)
    @init_date = init_date
    @end_date =  end_date
    @app_id = app_id
    @host_id = host_id
    @api_key = api_key
    @sensor = sensor
  end
  def newrelic_connection
    conn = Faraday.new(:url => "https://api.newrelic.com") do |faraday|
      faraday.request  :url_encoded
      faraday.response :logger
      faraday.response :json
      faraday.adapter  Faraday.default_adapter
    end
  end
  def retrive_data
    response=newrelic_connection.get do |req|
      req.url "/v2/servers/#{@host_id}/metrics/data.json"
      req.params['names[]'] = @sensor
      req.params['values[]'] = 'average_value'
      req.params['from'] = @init_date
      req.params['to'] = @end_date
      req.params['sumarize'] = 'true'
      req.headers['Content-Type'] = 'application/json'
      req.headers['X-Api-Key'] = @api_key
    end
    response.body['metric_data']['metrics'][0]['timeslices'][0]['values']['average_value']
  end
end
