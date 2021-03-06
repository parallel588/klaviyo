require_relative 'client_dsl'
require_relative 'errors'
module Klaviyo
  API_ENDPOINT = 'https://a.klaviyo.com'.freeze

  class Client
    extend ClientDSL

    attr_reader :api_key, :conn, :token
    def initialize(api_key, token, req_options = {})
      @api_key = api_key
      @token = token
      raise Errors::AuthenticationError, 'No API key provided.' unless @api_key
      raise Errors::AuthenticationError, 'No Token provided.' unless @token

      @conn = Faraday.new(default_req_options.merge(req_options)) do |f|
        f.request :url_encoded

        f.use Errors::RequestError
        f.adapter Faraday.default_adapter
      end
    end

    def build_params(params = {})
      options = params.merge(
        api_key: api_key,
        token: token
      )

      {
        data: Base64.strict_encode64(JSON.generate(options))
      }
    end

    def invoke(resource, method, options = {})
      constantize("klaviyo/#{resource}").send(
        method,
        options.merge(client: self)
      )
    end

    define_api_method resource: :people, action: :identify
    define_api_method resource: :people, action: :find
    define_api_method resource: :people, action: :exclusions
    define_api_method resource: :people, action: :exclude
    define_api_method resource: :people, action: :update
    define_api_method resource: :people, action: :events
    define_api_method resource: :people, action: :metric_events

    define_api_method resource: :lists, action: :all
    define_api_method resource: :lists, action: :find
    define_api_method resource: :lists, action: :create
    define_api_method resource: :lists, action: :update
    define_api_method resource: :lists, action: :delete
    define_api_method resource: :lists, action: :include_member_in_list?
    define_api_method resource: :lists, action: :include_member_in_segment?
    define_api_method resource: :lists, action: :subscribe
    define_api_method resource: :lists, action: :unsubscribe
    define_api_method resource: :lists, action: :batch_subscribe
    define_api_method resource: :lists, action: :unsubscribes

    define_api_method resource: :templates, action: :all
    define_api_method resource: :templates, action: :create
    define_api_method resource: :templates, action: :update
    define_api_method resource: :templates, action: :delete
    define_api_method resource: :templates, action: :clone
    define_api_method resource: :templates, action: :render
    define_api_method resource: :templates, action: :render_and_send

    define_api_method resource: :event, action: :track
    define_api_method resource: :event, action: :track_once

    private

    def default_req_options
      {
        url: API_ENDPOINT,
        ssl: {
          ca_path: Klaviyo::DEFAULT_CA_BUNDLE_PATH,
          ca_file: File.join(Klaviyo::DEFAULT_CA_BUNDLE_PATH, 'ca-certificates.crt')
        }
      }
    end

    def constantize(class_name)
      Object.module_eval(
        class_name.to_s.gsub(/\/(.?)/) {
          "::#{$1.upcase}"
        }.gsub(/(?:^|_)(.)/) { $1.upcase }
      )
    end
  end
end
