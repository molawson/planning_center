# encoding: utf-8

module PlanningCenter
  class Plan < Base
    def self.find_all_for_service_type(service_type_id, client)
      plans = client.get("/service_types/#{service_type_id}/plans.json")
      plans.map { |plan| new(plan, client) }
    end
  end
end
