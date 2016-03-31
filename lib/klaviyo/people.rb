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
    end

    extend ApiOperations
  end
end
