# encoding: utf-8

require 'codeclimate-test-reporter'
CodeClimate::TestReporter.start

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'planning_center'

require './spec/support/env'
require './spec/support/shared_lazy_attribute_examples'

require 'webmock/rspec'
WebMock.disable_net_connect!(allow: 'codeclimate.com')

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
  c.ignore_hosts 'codeclimate.com'
end

RSpec.configure do |c|
  c.treat_symbols_as_metadata_keys_with_true_values = true
end

def stub_get(path)
  stub_request(:get, pco_url(path))
end

def stub_post(path)
  stub_request(:post, pco_url(path))
end

def stub_put(path)
  stub_request(:put, pco_url(path))
end

def pco_url(path)
  [PlanningCenter::Client::SITE, path].join
end

def organization
  VCR.use_cassette('PlanningCenter::Organization/organization') do
    PlanningCenter::Organization.find(client)
  end
end

def plan
  VCR.use_cassette('PlanningCenter::Plan/plan') do
    PlanningCenter::Plan.find(13643464, client)
  end
end
