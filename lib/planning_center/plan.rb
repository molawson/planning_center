# encoding: utf-8

module PlanningCenter
  class Plan < Base
    include LazyAttributes

    lazy_accessor(
      :service_type,
      :total_length,
      :total_length_formatted,
      :comma_separated_attachment_type_ids,
      :plan_notes,
      :positions,
      :items,
      :service_times,
      :rehearsal_times,
      :other_times,
      :multi_day,
      :attachments,
      :sort_by,
      :plan_people,
      :prev_plan_id,
      :plan_contributions
    )

    def self.find_all_for_service_type(service_type_id, client)
      plans = client.get("/service_types/#{service_type_id}/plans.json")
      plans.map { |plan| new(plan, client) }
    end

    def self.find(id, client)
      attrs = client.get("/plans/#{id}.json")
      plan = new(attrs, client)
      plan.load_state = :loaded
      plan
    end

    def items
      attrs['items'].map { |item_attrs| Item.new(item_attrs, client) }
    end

    private

    def complete_attrs
      @complete_attrs ||= client.get("/plans/#{id}.json")
    end
  end
end
