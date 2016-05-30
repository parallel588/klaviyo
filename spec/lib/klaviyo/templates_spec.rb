require 'spec_helper'
describe Klaviyo::Templates do
  let(:client) { Klaviyo::Client.new 'FakeApi', 'Token' }
  context 'API' do
    it 'all'
    it 'create'
    it 'update'
    it 'delete'
    it 'clone'
    it 'render'
    it 'render_and_send'
  end
end
