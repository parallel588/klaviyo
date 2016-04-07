require_relative 'collection'
require_relative 'entry'
module Klaviyo
  module Lists
    # https://www.klaviyo.com/docs/api/lists
    #
    module ApiOperations

      def all(client:, page: 0, per: 50)
        Collection.new(
          client.conn.get(
          '/api/v1/lists',
          api_key: client.api_key,
          page: page, count: per
        ).body)
      end

      def find(client:, id:)
        Entry.new(
          client.conn.get(
          "/api/v1/list/#{id}", api_key: client.api_key
        ).body)
      end

      def create(client:, name:, list_type: 'standart')
        res = client.conn.post(
          '/api/v1/lists',
          api_key: client.api_key,
          name: name,
          list_type: list_type
        )
        Entry(res.body)
      end

      def update(client:, id:, name:)
        res = client.conn.put(
          "/api/v1/list/#{id}",
          api_key: client.api_key,
          name: name
        )
        Entry.new(res.body)
      end

      def delete(client:, id:)
        res = client.conn.delete(
          "/api/v1/list/#{id}",
          api_key: client.api_key
        )
        Entry.new(res.body)
      end

      def include_member_in_list?(client:, id:, email:)
        client.conn.get(
          "/api/v1/list/#{id}/members",
          api_key: client.api_key,
          email: email
        )
      end

      def include_member_in_segment?(client:, segment_id:, email:)
        client.conn.get(
          "/api/v1/segment/#{segment_id}/members",
          api_key: client.api_key,
          email: email
        )
      end

      #
      # @id - list id
      #
      def subscribe(client:, id:, email:, properties: {}, confirm_optin: true)
        client.conn.post(
          "/api/v1/list/#{id}/members",
          api_key: client.api_key,
          email: email,
          properties: properties,
          confirm_optin: confirm_optin
        )
      end

      def unsubscribe(client:, id:, email:, ts: Time.now.to_i)
        client.conn.post(
          "/api/v1/list/#{id}/members/exclude",
          api_key: client.api_key,
          email: email,
          timestamp: ts
        )
      end

      #
      # @id - list id
      #
      def batch_subscribe(client:, id:, batch:, confirm_optin: true)
        client.conn.post(
          "/api/v1/list/#{id}/members/batch",
          api_key: client.api_key,
          batch: batch,
          confirm_optin: confirm_optin
        )
      end

      #
      # @reason - unsubscribed, bounced, invalid_email, reported_spam and manually_excluded.
      # @sort - asc\desc
      #
      def unsubscribes(client:, id:, reason: 'unsubscribed', sort: 'asc')
        client.conn.post(
          "/api/v1/list/#{id}/exclusions",
          api_key: client.api_key,
          reason: reason,
          sort: sort
        )
      end
    end
  end
end
