# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::Plan do
  describe '.find_all_for_service_type', :vcr do
    it 'returns an array of Plans' do
      plans = PlanningCenter::Plan.find_all_for_service_type(230211, client)
      expect(plans.first).to be_a(PlanningCenter::Plan)
    end
  end

  describe '.find' do
    it 'returns a plan' do
      expect(plan.plan_title).to eq('Jesus Is a Better Teacher')
      expect(plan.total_length).to eq(4650)
    end
  end

  describe '#total_length', :vcr do
    it_behaves_like 'lazy attribute' do
      let(:partial_object) do
        PlanningCenter::Plan.
          find_all_for_service_type(230211, client).
          first
      end
      let(:complete_object) { plan }
      let(:lazy_method) { :total_length }
      let(:lazy_value) { 4650 }
    end
  end

  describe '#items' do
    it 'returns an array of items' do
      expect(plan.items.first).to be_a(PlanningCenter::Item)
    end
  end
end
