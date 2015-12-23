require 'spec_helper'
require 'webmock/rspec'

require_relative '../lib/retrive_metrics.rb'

describe 'Getmetrics' do
  let(:init_date) { '2015-12-22T19:25:00+00:00' }
  let(:end_date) { '2015-12-22T20:25:00+00:00' }
  let(:app_id) {'app1'}
  let(:host_id) {'2732969'}
  let(:api_key) {'XXX-XXXX-XXX'}
  let(:sensor) {'System/CPU/System/percent'}
  let(:response_body) { '{"metric_data":{"from":"2015-12-22T19:25:00+00:00","to":"2015-12-22T21:55:00+00:00","metrics":[{"name":"System/CPU/System/percent","timeslices":[{"from":"2015-12-22T19:25:00+00:00","to":"2015-12-22T21:55:00+00:00","values":{"average_value":1.54}}]}]}}'}

  let(:metric) {
    GetMetrics.new(init_date,end_date,sensor,app_id,host_id,api_key)
  }
  it 'retrives average value' do
    stub_request(:get, "https://api.newrelic.com/v2/servers/#{host_id}/metrics/data.json").with(
      :query => {
        "names[]" => sensor,
        "values[]" => "average_value",
        "from" => init_date,
        "to" => end_date,
        "sumarize" => "true" },
      :headers => {
      'Content-Type' => 'application/json',
      'X-Api-Key' => api_key
      }
    ).to_return(
      :body => response_body,
      :status => 200,
      :headers => {
        'Content-Length' => 251,
        'Content-Type' => 'application/json'
      }
    )

    expect(metric.retrive_data).to eq(1.54)
  end
end
