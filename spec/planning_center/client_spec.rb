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
    let(:url) { '/organization.json' }

    it 'makes a get request via the oauth access token' do
      org_request = stub_get(url).to_return(body: { abc: 123 }.to_json)
      client.get(url)
      assert_requested org_request
    end

    it 'raises an APIError for a bad response' do
      stub_get(url).to_return(body: nil.to_json)
      expect { client.get(url) }.to raise_error(PlanningCenter::APIError)
    end
  end

  describe '#post' do
    let(:url) { '/songs.json' }
    let(:body) { { abc: 123 } }

    it 'makes a post request via the oauth access token' do
      song_request = stub_post(url).to_return(body: body.to_json)
      client.post(url, body)
      assert_requested song_request
    end

    it 'raises an APIError for a bad response' do
      stub_post(url).to_return(body: nil.to_json)
      expect { client.post(url, body) }.to raise_error(PlanningCenter::APIError)
    end
  end

  describe '#put' do
    let(:url) { '/songs/1.json' }
    let(:body) { { abc: 123 } }

    it 'makes a put request via the oauth access token' do
      song_request = stub_put(url).to_return(body: body.to_json)
      client.put(url, body)
      assert_requested song_request
    end

    it 'raises an APIError for a bad response' do
      stub_put(url).to_return(body: nil.to_json)
      expect { client.put(url, body) }.to raise_error(PlanningCenter::APIError)
    end
  end
end
