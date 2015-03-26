# encoding: utf-8

module PlanningCenter
  class Base
    attr_accessor :attrs

    def initialize(attrs, client)
      @attrs = attrs
      @client = client
    end

    def method_missing(method_name, *args)
      attrs.fetch(method_name.to_s) { super }
    end

    def respond_to_missing?(method_name, _include_private = false)
      attrs.key?(method_name.to_s) || super
    end

    private

    attr_reader :client
  end
end
