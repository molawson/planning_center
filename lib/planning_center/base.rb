module PlanningCenter
  class Base
    def initialize(attrs, client)
      @attrs = attrs
      @client = client
    end

    def method_missing(method_name, *args)
      attrs.fetch(method_name.to_s) { super }
    end

    def respond_to_missing?(method_name, include_private = false)
      attrs.key? method_name.to_s
    end

    private

    attr_reader :attrs, :client
  end
end
