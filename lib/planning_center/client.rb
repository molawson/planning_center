# encoding: utf-8

require 'oauth'
require 'oauth/signature/plaintext'
require 'json'

module PlanningCenter
  class Client
    SITE = 'https://planningcenteronline.com'

    attr_accessor(
      :access_token,
      :access_token_secret,
      :consumer_key,
      :consumer_secret
    )

    def initialize
      yield(self) if block_given?
    end

    def organization
      Organization.find(self)
    end

    def get(path, headers = {})
      request(:get, path, headers)
    end

    def post(path, body, headers = {})
      request_with_body(:post, path, body, headers)
    end

    def put(path, body, headers = {})
      request_with_body(:put, path, body, headers)
    end

    private

    def default_headers
      {
        'content-type' => 'application/json',
        'accept' => 'application/json'
      }
    end

    def oauth
      @oauth ||= OAuth::AccessToken.new(
        consumer,
        access_token,
        access_token_secret
      )
    end

    def consumer
      @consumer ||= OAuth::Consumer.new(
        consumer_key,
        consumer_secret,
        site: SITE,
        signature_method: 'plaintext'
      )
    end

    def request(type, path, headers = {})
      response = oauth.request(type, path, default_headers.merge(headers))
      parse_response(response)
    end

    def request_with_body(type, path, body, headers = {})
      response = oauth.request(type, path, body, default_headers.merge(headers))
      parse_response(response)
    end

    def parse_response(response)
      JSON.parse(response.body)
    rescue JSON::ParserError
      raise(
        APIError,
        'Invalid response from API. ' \
        "Code: #{response.code}, " \
        "Body: #{response.body.inspect} "
      )
    end
  end
end
