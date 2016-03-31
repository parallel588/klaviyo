module Klaviyo
  module Templates
    # https://www.klaviyo.com/docs/api/email-templates
    #
    module ApiOperations

      def all(client:)
        client.conn.get('/api/v1/email-templates', api_key: client.api_key)
      end

      def create(client:, name:, html:)
        client.conn.post(
          '/api/v1/email-templates',
          api_key: client.api_key,
          name: name,
          html: html
        )
      end

      def update(client:, id:, name:, html:)
        client.conn.put(
          "/api/v1/email-template/#{id}",
          api_key: client.api_key,
          name: name,
          html: html
        )
      end

      def delete(client:, id:)
        client.conn.delete(
          "/api/v1/email-template/#{id}",
          api_key: client.api_key
        )
      end

      def clone(client:, id:, name:)
        client.conn.post(
          "/api/v1/email-template/#{id}/clone",
          api_key: client.api_key,
          name: name
        )
      end

      def render(client:, id:, context:)
        client.conn.post(
          "/api/v1/email-template/#{id}/render",
          api_key: client.api_key,
          context: context
        )
      end

      def render_and_send(
            client:, id:, context:,
            service:, from_email:, from_name:, subject:, to:
          )
        client.conn.post(
          "/api/v1/email-template/#{id}/send",
          api_key: client.api_key,
          context: context,
          service: service,
          from_email: from_email,
          from_name: from_name,
          subject: subject,
          to: to
        )
      end
    end
  end
end
