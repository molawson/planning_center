# encoding: utf-8

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'planning_center'

require './spec/support/env'

require 'webmock/rspec'
WebMock.disable_net_connect!

require 'vcr'
VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
  c.filter_sensitive_data('<PCO_CONSUMER_KEY>') do
    test_consumer_key
  end
  c.filter_sensitive_data('<PCO_CONSUMER_SECRET>') do
    test_consumer_secret
  end
  c.filter_sensitive_data('<PCO_ACCESS_TOKEN>') do
    test_access_token
  end
  c.filter_sensitive_data('<PCO_ACCESS_TOKEN_SECRET>') do
    test_access_token_secret
  end
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

def stub_get(path)
  stub_request(:get, pco_url(path))
end

def pco_url(path)
  [PlanningCenter::Client::SITE, path].join
end
