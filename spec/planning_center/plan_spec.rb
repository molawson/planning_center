# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::Plan do
  describe '.find_all_for_service_type', :vcr do
    it 'returns an array of Plans' do
      plans = PlanningCenter::Plan.find_all_for_service_type(230211, client)
      expect(plans.first).to be_a(PlanningCenter::Plan)
    end
  end
end
