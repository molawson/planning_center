# encoding: utf-8

module PlanningCenter
  module LazyAttributes
    module ClassMethods
      private

      def lazy_accessor(*names)
        names.each do |name|
          define_method(name) do
            load_attrs
            attrs[name.to_s]
          end
        end
      end
    end

    def self.included(base)
      base.extend(ClassMethods)
    end

    attr_writer :load_state

    def load_state
      @load_state ||= :ghost
    end

    private

    def load_attrs
      return if load_state == :loaded

      self.attrs = complete_attrs
      self.load_state = :loaded
    end
  end
end
