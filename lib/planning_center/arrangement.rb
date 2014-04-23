# encoding: utf-8

module PlanningCenter
  class Arrangement < Base
    def self.find(id, client)
      attrs = client.get("/arrangements/#{id}.json")
      new(attrs, client)
    end
  end
end
