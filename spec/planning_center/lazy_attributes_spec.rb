# encoding: utf-8

require 'spec_helper'

class DummyCar
  include PlanningCenter::LazyAttributes

  attr_accessor :attrs
  lazy_accessor :seats

  def initialize(attrs = {})
    @attrs = attrs
  end

  def method_missing(method_name, *args)
    attrs.fetch(method_name.to_s) { super }
  end

  private

  def complete_attrs
    { 'make' => 'Ford', 'model' => 'Focus', 'seats' => 5 }
  end
end

describe PlanningCenter::LazyAttributes do
  describe '.lazy_accessor' do
    it 'defines reader methods for each name given' do
      car = DummyCar.new
      respond_to = lambda do
        car.respond_to?(:giraffe) && car.respond_to?(:wildebeest)
      end
      expect { car.class.send(:lazy_accessor, :giraffe, :wildebeest) }.
        to change { respond_to.call }.from(false).to(true)
    end
  end

  describe '#seats' do
    it_behaves_like 'lazy attribute' do
      let(:partial_object) do
        DummyCar.new('make' => 'Ford', 'model' => 'Focus')
      end
      let(:complete_object) do
        DummyCar.new('make' => 'Ford', 'model' => 'Focus', 'seats' => 5)
      end
      let(:lazy_method) { :seats }
      let(:lazy_value) { 5 }
    end
  end
end
