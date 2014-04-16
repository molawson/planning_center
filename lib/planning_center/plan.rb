# encoding: utf-8

module PlanningCenter
  class Plan < Base
    def self.lazy_accessor(*names)
      names.each do |name|
        define_method(name) do
          load_attrs
          attrs[name.to_s]
        end
      end
    end

    attr_writer :load_state

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

    def load_state
      @load_state ||= :ghost
    end

    private

    def load_attrs
      return if load_state == :loaded

      self.attrs = client.get("/plans/#{id}.json")
      self.load_state = :loaded
    end
  end
end
