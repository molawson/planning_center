# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::Arrangement do
  describe '.find', :vcr do
    it 'returns an arrangement' do
      arrangement = PlanningCenter::Arrangement.find(8535124, client)
      expect(arrangement.name).to eq('Default Arrangement')
    end
  end
end
