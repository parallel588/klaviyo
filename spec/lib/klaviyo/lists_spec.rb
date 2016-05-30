require 'spec_helper'
describe Klaviyo::Lists do
  let(:client) { Klaviyo::Client.new 'FakeApi', 'Token' }
  context 'API' do
    it 'all'
    it 'find'
    it 'create'
    it 'update'
    it 'delete'
    it 'include_member_in_list?'
    it 'include_member_in_segment?'
    it 'subscribe'
    it 'unsubscribe'
    it 'batch_subscribe'
    it 'unsubscribes'
  end
end
