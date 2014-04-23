# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::Item do

  describe '#arrangement' do
    it 'returns an arrangement' do
      item = plan.items.first
      expect(item.arrangement).to be_a(PlanningCenter::Arrangement)
    end
  end
end
