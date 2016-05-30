require 'spec_helper'
describe Klaviyo::Client do
  let(:client) { Klaviyo::Client.new 'FakeApi', 'Token' }
  context 'Api Methods' do
    context 'people' do
      [:identify, :find, :exclusions, :exclude,
       :update, :events, :metric_events].each do |m|
        it "should define method api #people.#{m}" do
          expect(client.people.respond_to?(m)).to be true
        end
      end
    end
    context 'lists' do
      [:all, :find, :create, :update, :delete, :include_member_in_list?,
       :include_member_in_segment?, :subscribe, :unsubscribe, :batch_subscribe,
       :unsubscribes
      ].each do |m|
        it "should define method api #lists.#{m}" do
          expect(client.lists.respond_to?(m)).to be true
        end
      end
    end

    context 'templates' do
      [:all, :create, :update, :delete,
       :clone, :render, :render_and_send].each do |m|
        it "should define method api #templates.#{m}" do
          expect(client.templates.respond_to?(m)).to be true
        end
      end
    end

    context 'event' do
      [:track, :track_once].each do |m|
        it "should define method api #event.#{m}" do
          expect(client.event.respond_to?(m)).to be true
        end
      end
    end
  end

  it '#build_params' do
    expect(
      client.build_params(name: 'Jimm', event: 'sign in')
    ).to eq(data: "eyJuYW1lIjoiSmltbSIsImV2ZW50Ijoic2lnbiBpbiIsImFwaV9rZXkiOiJGYWtlQXBpIiwidG9rZW4iOiJUb2tlbiJ9" )
  end

  context 'invoke' do
    it 'should call resource api' do
      expect(Klaviyo::People).to receive(:find).with(id: '34ds', client: client)
      client.invoke(:people, :find, id: '34ds')
    end
  end
end
