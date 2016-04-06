module Klaviyo
  API_ENDPOINT = 'https://a.klaviyo.com'

  class Client
    attr_reader :api_key, :conn, :token
    def initialize(api_key, token)
      @api_key = api_key
      @token = token
      @conn = Faraday.new(
        url: API_ENDPOINT,
        ssl: { ca_path: Klaviyo::DEFAULT_CA_BUNDLE_PATH }
      ) do |b|
        b.headers['Accept'] = 'application/json'
        b.request  :url_encoded
        b.response :logger
        b.response :json, content_type: 'application/json'
        b.adapter  Faraday.default_adapter
      end
    end

    def build_params(params = {})
      options = params.merge(
        api_key: api_key,
        token: token
      )

      {
        data: Base64.encode64(JSON.generate(options)).delete("\n")
      }
    end

    def invoke(resource, method, options = {})
      constantize("klaviyo/#{resource}").send(
        method,
        options.merge(client: self)
      )
    end

    private

    def constantize(class_name)
      Object.module_eval(class_name.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase })
    end
  end
end
