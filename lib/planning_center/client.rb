require 'oauth'
require 'json'

module PlanningCenter
  class Client
    SITE = 'https://planningcenteronline.com'

    attr_accessor :access_token, :access_token_secret, :consumer_key, :consumer_secret

    def initialize
      yield(self) if block_given?
    end

    def organization
      Organization.find(self)
    end

    def get(path, headers = {})
      response = request(:get, path, headers)
      parse_response(response)
    end

    private

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
        site: SITE
      )
    end

    def request(type, path, headers)
      oauth.send(type.to_sym, path, headers)
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
