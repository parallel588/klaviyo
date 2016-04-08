module Klaviyo
  module People
    # https://www.klaviyo.com/docs/api/people
    #
    module ApiOperations
      Result = Struct.new(:response) do
        def success?
          response.to_s == '1'
        end
      end
      ErrorResult = Struct.new(:response) do
        def success?; false; end
        def status; response['status']; end
        def message; response['message']; end
      end

      Person = Struct.new(:attrs) do
        def method_missing(method_name, *arguments, &block)
          if attrs.key?(method_name.to_s)
            attrs[method_name.to_s]
          elsif attrs.key?("$#{method_name}")
            attrs["$#{method_name}"]
          else
            super
          end
        end
      end

      # https://www.klaviyo.com/docs/http-api#people
      # invoke(:people, :identify, properties: { '$email': 'useremail@ua.com' })
      #
      def identify(client:, properties: {})
        res = client.conn.get(
          '/api/identify',
          client.build_params(properties: properties)
        )
        Result.new(res.body)
      end

      #
      # @reason - unsubscribed, bounced, invalid_email, reported_spam, manually_excluded
      # @sort - asc|desc
      #
      def exclusions(client:, reason: 'unsubscribed', sort: 'asc')
        client.conn.get(
          '/api/v1/people/exclusions',
          api_key: client.api_key,
          reason: reason,
          sort: sort
        )
      end

      def exclude(client:, email:, ts: Time.now.to_i)
        client.conn.post(
          '/api/v1/people/exclusions',
          api_key: client.api_key,
          email: email,
          timestamp: ts
        )
      end

      def find(client:, id:)
        res = client.conn.get("/api/v1/person/#{id}", api_key: client.api_key)
        if res.success?
          Person.new(res.body)
        else
          ErrorResult.new(res.body)
        end
      end

      def update(client:, id:, attrs: {})
        client.conn.put(
          "/api/v1/person/#{id}",
          { api_key: client.api_key }.merge(attrs)
        )
      end

      def events(client:, id:, sort: 'desc', per: 100, since: Time.now.to_i)
        client.conn.get(
          "/api/v1/person/#{id}/metrics/timeline",
          api_key: client.api_key,
          sort: sort,
          count: per,
          since: since
        )
      end

      def metric_events(client:, id:, metric_id:,
                        sort: 'desc', per: 100,
                        since: Time.now.to_i)
        client.conn.get(
          "/api/v1/person/#{id}/metric/#{metric_id}/timeline",
          api_key: client.api_key,
          sort: sort,
          count: per,
          since: since
        )
      end

    end
  end
end
