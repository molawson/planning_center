# encoding: utf-8

module PlanningCenter
  class Organization < Base
    def self.find(client)
      attrs = client.get('/organization.json')
      new(attrs, client)
    end

    def service_types
      attrs['service_types'].map do |service_type_attrs|
        ServiceType.new(service_type_attrs, client)
      end
    end
  end
end
