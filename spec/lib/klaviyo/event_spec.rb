require 'spec_helper'
describe Klaviyo::Event do
  # https://www.klaviyo.com/docs/http-api
  let(:client) { Klaviyo::Client.new 'FakeApi', 'Token' }
  context 'API' do
    it 'track' do
      stub_request(:get, /https:\/\/a.klaviyo.com\/api\/track.*/).to_return(status: 200, body: '1')
      res = Klaviyo::Event.track(client: client, event_name: 'test-event', customer_properties: { name: 'fake Name', email: 'fake@test.com'})
      expect(res.success?).to be true
    end

    it 'track' do
      stub_request(:get, /https:\/\/a.klaviyo.com\/api\/track-once.*/).to_return(status: 200, body: '1')
      res = Klaviyo::Event.track_once(client: client, event_name: 'test-event', customer_properties: { name: 'fake Name', email: 'fake@test.com'})
      expect(res.success?).to be true
    end
  end
end
