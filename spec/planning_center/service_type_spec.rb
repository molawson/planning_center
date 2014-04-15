# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::ServiceType do
  describe '#plans', :vcr do
    it 'returns an array of plans' do
      service_type = organization.service_types.first
      expect(service_type.plans.first).to be_a(PlanningCenter::Plan)
    end
  end
end
