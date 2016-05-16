require_relative 'event/api_operations'

module Klaviyo
  module Event
    Result = Struct.new(:response) do
      def success?
        response.to_s == '1'
      end
    end

    extend ApiOperations
  end
end
