require_relative 'entry'
module Klaviyo
  module Lists

    class Collection
      attr_reader :data

      def initialize(data)
        @data = data
      end

      def items
        @items ||= data.fetch('data') { [] }.map { |j| Entry.new(j) }
      end

      def meta
        @meta ||= data.except('data')
      end
    end
  end
end
