# encoding: utf-8

require 'awesome_print'

require 'dotenv'
Dotenv.load(
  File.expand_path('../../../.local.env', __FILE__),
  File.expand_path('../../../.env',  __FILE__)
)

def test_consumer_key
  ENV['PCO_TEST_CONSUMER_KEY']
end

def test_consumer_secret
  ENV['PCO_TEST_CONSUMER_SECRET']
end

def test_access_token
  ENV['PCO_TEST_ACCESS_TOKEN']
end

def test_access_token_secret
  ENV['PCO_TEST_ACCESS_TOKEN_SECRET']
end

def client
  @client ||= PlanningCenter::Client.new do |c|
    c.consumer_key = test_consumer_key
    c.consumer_secret = test_consumer_secret
    c.access_token = test_access_token
    c.access_token_secret = test_access_token_secret
  end
end
