module Klaviyo
  module Lists

    class Entry
      attr_reader :data

      def initialize(data)
        @data = data
      end
    end
  end
end
