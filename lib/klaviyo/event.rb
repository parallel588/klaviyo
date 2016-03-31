module Klaviyo
  module Event
    module ApiOperations
      Result = Struct.new(:response) do
        def success?
          response.to_s == '1'
        end
      end

      def track(client:, event_name:,
                customer_properties:,
                properties: {},
                time: nil)


        res = client.conn.get(
          '/api/track',
          client.build_params(
            event: event_name,
            customer_properties: customer_properties,
            properties: properties,
            time: time
          )
        )
        Result.new(res.body)
      end

      def track_once(client:, event_name:,
                     customer_properties:,
                     properties: {},
                     time: nil)
        res = client.conn.get(
          '/api/track-once',
          client.build_params(
            event: event_name,
            customer_properties: customer_properties,
            properties: properties,
            time: time
          )
        )
        Result.new(res.body)
      end

    end

    extend ApiOperations
  end
end
