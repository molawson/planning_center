# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::Plan do
  describe '.find_all_for_service_type', :vcr do
    it 'returns an array of Plans' do
      plans = PlanningCenter::Plan.find_all_for_service_type(230211, client)
      expect(plans.first).to be_a(PlanningCenter::Plan)
    end
  end

  describe '.find', :vcr do
    it 'returns a plan' do
      plan = PlanningCenter::Plan.find(13531990, client)
      expect(plan.plan_title).to eq('Jesus Is a Better Teacher')
      expect(plan.total_length).to eq(4710)
    end
  end

  describe '.lazy_accessor' do
    it 'defines reader methods for each name given' do
      plan = PlanningCenter::Plan.new({}, client)
      respond_to = lambda do
        plan.respond_to?(:wildebeest) && plan.respond_to?(:giraffe)
      end
      expect { PlanningCenter::Plan.lazy_accessor(:wildebeest, :giraffe) }.
        to change { respond_to.call }.from(false).to(true)
    end
  end

  describe '#total_length', :vcr do
    context 'the plan is not fully loaded' do
      it 'loads the full plan and returns the plan notes' do
        plan = PlanningCenter::Plan.
          find_all_for_service_type(230211, client).
          first
        expect { plan.total_length }.
          to change { plan.load_state }.from(:ghost).to(:loaded)
        expect(plan.total_length).to eq(4710)
      end
    end

    context 'the plan is fully loaded' do
      it 'returns the total_length' do
        plan = PlanningCenter::Plan.find(13531990, client)
        expect { plan.total_length }.to_not change { plan.load_state }
        expect(plan.total_length).to eq(4710)
      end
    end
  end

  describe '#multi_day', :vcr do
    context 'the plan is not fully loaded' do
      it 'loads the full plan and returns the plan notes' do
        plan = PlanningCenter::Plan.
          find_all_for_service_type(230211, client).
          first
        expect { plan.multi_day }.
          to change { plan.load_state }.from(:ghost).to(:loaded)
        expect(plan.multi_day).to eq(false)
      end
    end

    context 'the plan is fully loaded' do
      it 'returns the multi_day' do
        plan = PlanningCenter::Plan.find(13531990, client)
        expect { plan.multi_day }.to_not change { plan.load_state }
        expect(plan.multi_day).to eq(false)
      end
    end
  end
end
