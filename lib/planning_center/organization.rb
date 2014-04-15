module PlanningCenter
  class Organization < Base
    def self.find(client)
      attrs = client.get('/organization.json')
      new(attrs, client)
    end
  end
end
