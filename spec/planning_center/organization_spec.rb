# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::Organization do
  describe '.find' do
    it 'returns an organization', :vcr do
      expect(
        PlanningCenter::Organization.find(client).name
      ).to eq('The Bridgeway Church')
    end
  end

  describe '#service_types' do
    it 'returns an array of service types', :vcr do
      organization = PlanningCenter::Organization.find(client)
      expect(
        organization.service_types.first
      ).to be_a(PlanningCenter::ServiceType)
    end
  end
end
