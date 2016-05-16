module Klaviyo
  # https://www.klaviyo.com/docs/http-api
  module ApiOperations
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

      Klaviyo::Event::Result.new(res.body)
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
      Klaviyo::Event::Result.new(res.body)
    end
  end
end
