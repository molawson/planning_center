require 'spec_helper'

describe PlanningCenter::Organization do
  describe '.find' do
    it 'returns an organization', :vcr do
      expect(
        PlanningCenter::Organization.find(client).name
      ).to eq('The Bridgeway Church')
    end
  end
end
