module Klaviyo
  module Resource
    KlaviyoObject = Struct.new(:attrs) do
      def method_missing(method_name, *arguments, &block)
        if attrs.key?(method_name.to_s) || attrs.key?("$#{method_name}")
          attr_value = attrs[method_name.to_s] || attrs["$#{method_name}"]
          if attr_value.is_a?(Hash) &&
             attr_value.key?('object') && attr_value.key?('id')
            attrs[method_name.to_s] = Klaviyo::Resource.build(attr_value)
          else
            attr_value
          end
        else
          super
        end
      end
    end

    class KlaviyoCollection
      include Enumerable

      attr_reader :meta, :items

      def initialize(data)
        @items = data.delete('data').map { |attrs| Klaviyo::Resource.build(attrs) }
        @meta = data
      end

      def each(&blk)
        item.each(&blk)
      end
    end

    class Person < KlaviyoObject; end
    class List < KlaviyoObject; end
    class Folder < KlaviyoObject; end
    class Membership < KlaviyoObject; end

    def self.build(params)
      attrs = params.is_a?(String) ? MultiJson.load(params) : params
      object = attrs.delete('object')
      case object.to_s
      when 'person'
        Person.new(attrs)
      when 'list'
        List.new(attrs)
      when 'folder'
        Folder.new(attrs)
      when 'membership'
        Membership.new(attrs)
      else
        KlaviyoObject.new(attrs)
      end

    end

    def self.build_collection(data)
      KlaviyoCollection.new(data)
    end

  end
end
