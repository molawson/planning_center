# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::Organization do
  describe '.find' do
    it 'returns an organization' do
      expect(organization.name).to eq('The Bridgeway Church')
    end
  end

  describe '#service_types' do
    it 'returns an array of service types' do
      expect(
        organization.service_types.first
      ).to be_a(PlanningCenter::ServiceType)
    end
  end
end
