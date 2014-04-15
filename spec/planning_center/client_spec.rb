# encoding: utf-8

require 'spec_helper'

describe PlanningCenter::Client do
  describe '#organization' do
    it 'finds the organziation for the given credentials' do
      subject = PlanningCenter::Client.new
      organization = double('organization')
      expect(PlanningCenter::Organization).to(
        receive(:find).with(subject).and_return(organization)
      )
      expect(subject.organization).to eq(organization)
    end
  end

  describe '#get' do
    it 'makes a get request via the oauth access token' do
      url = '/organization.json'
      org_request = stub_get(url).to_return(body: { abc: 123 }.to_json)
      client.get(url)
      assert_requested org_request
    end

    it 'raises an APIError for a bad response' do
      url = '/organization.json'
      stub_get(url).to_return(body: nil.to_json)
      expect { client.get(url) }.to raise_error(PlanningCenter::APIError)
    end
  end
end
