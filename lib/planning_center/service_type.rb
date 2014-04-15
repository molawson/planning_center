# encoding: utf-8

module PlanningCenter
  class ServiceType < Base
    def plans
      @plans ||= Plan.find_all_for_service_type(id, client)
    end
  end
end
