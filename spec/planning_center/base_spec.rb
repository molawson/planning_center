# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::Base do
  describe '#method_missing' do
    it 'delegates method calls to the attrs hash' do
      attrs = { 'id' => 123 }
      expect(PlanningCenter::Base.new(attrs, client).id).to eq(123)
    end

    it 'returns nil for nil attrs values' do
      attrs = { 'name' => nil }
      expect(PlanningCenter::Base.new(attrs, client).name).to be_nil
    end

    it 'raises NoMethodError for unrecognized method calls' do
      expect { PlanningCenter::Base.new({}, client).giraffe }.to(
        raise_error(NoMethodError)
      )
    end
  end

  describe '#respond_to_missing?' do
    it 'responds to methods matching hash keys' do
      attrs = { 'id' => 123 }
      expect(
        PlanningCenter::Base.new(attrs, client).respond_to?(:id)
      ).to be_true
    end

    it 'responds to methods with nil values' do
      attrs = { 'name' => nil }
      expect(
        PlanningCenter::Base.new(attrs, client).respond_to?(:name)
      ).to be_true
    end

    it 'does not respond to methods not matching hash keys' do
      expect(
        PlanningCenter::Base.new({}, client).respond_to?(:giraffe)
      ).to be_false
    end
  end
end
