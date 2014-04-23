# encoding: utf-8

module PlanningCenter
  class Item < Base
    def arrangement
      @arrangement ||= Arrangement.find(arrangement_id, client)
    end
  end
end
