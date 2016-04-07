module Klaviyo
  module People
    module ApiOperations
      Result = Struct.new(:response) do
        def success?
          response.to_s == '1'
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
    end

    extend ApiOperations
  end
end
