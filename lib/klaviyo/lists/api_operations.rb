module Klaviyo
  module Lists
    # https://www.klaviyo.com/docs/api/lists
    #
    module ApiOperations

      def all(client:, page: 0, per: 50)
        Klaviyo::Resource.build_collection(
          client.conn.get('/api/v1/lists',
                          api_key: client.api_key,
                          page: page, count: per
                         ).body
        )
      end

      def find(client:, id:)
        Klaviyo::Resource.build(
          client.conn.get("/api/v1/list/#{id}",
                          api_key: client.api_key
                         ).body
        )
      end

      def create(client:, name:, list_type: 'standart')
        Klaviyo::Resource.build(
          client.conn.post('/api/v1/lists',
                           api_key: client.api_key,
                           name: name,
                           list_type: list_type
                          ).body
        )
      end

      def update(client:, id:, name:)
        Klaviyo::Resource.build(
          client.conn.put("/api/v1/list/#{id}",
                          api_key: client.api_key,
                          name: name
                         ).body
        )
      end

      def delete(client:, id:)
        Klaviyo::Resource.build(
          client.conn.delete("/api/v1/list/#{id}",
                             api_key: client.api_key
                            ).body
        )
      end

      def include_member_in_list?(client:, id:, email:)
        Klaviyo::Resource.build_collection(
          client.conn.get("/api/v1/list/#{id}/members",
                          api_key: client.api_key,
                          email: email
                         ).body
        )
      end

      def include_member_in_segment?(client:, segment_id:, email:)
        Klaviyo::Resource.build_collection(
          client.conn.get("/api/v1/segment/#{segment_id}/members",
                          api_key: client.api_key,
                          email: email
                         ).body
        )
      end

      #
      # @id - list id
      #
      def subscribe(client:, id:, email:, properties: {}, confirm_optin: false)
        Klaviyo::Resource.build(
          client.conn.post("/api/v1/list/#{id}/members",
                           api_key: client.api_key,
                           email: email,
                           properties: properties,
                           confirm_optin: confirm_optin
                          ).body
        )
      end

      def unsubscribe(client:, id:, email:, ts: Time.now.to_i)
        Klaviyo::Resource.build(
          client.conn.post("/api/v1/list/#{id}/members/exclude",
                           api_key: client.api_key,
                           email: email,
                           timestamp: ts
                          ).body
        )
      end

      #
      # @id - list id
      #
      def batch_subscribe(client:, id:, batch: [], confirm_optin: false)
        client.conn.post(
          "/api/v1/list/#{id}/members/batch",
          api_key: client.api_key,
          batch: JSON.generate(batch),
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
