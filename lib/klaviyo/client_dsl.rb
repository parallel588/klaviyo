module Klaviyo
  module ClientDSL
    def define_api_method(resource:, action:)
      @@resources ||= {}

      @@resources[resource] ||
        begin
          @@resources[resource] = Class.new do
            class << self
              attr_accessor :client

              def define_action(resource, action)
                define_singleton_method action do |*args|
                  client.invoke(resource, action, *args)
                end
              end
            end
          end

          define_method resource do
            @@resources[resource].client = self
            @@resources[resource]
          end
        end

      @@resources[resource].define_action(resource, action)
    end
  end
end
