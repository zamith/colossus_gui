module ColossusBets
  class APIError < StandardError; end

  class APIConnector
    def self.instance
      @api ||= new
    end

    def initialize
      @tokens = sessions.create(
        api_key: ENV.fetch("API_KEY"),
        api_secret: ENV.fetch("API_SECRET")
      )
    end

    def pools
      Pools.new(tokens: tokens)
    end

    def tickets
      Tickets.new(tokens: tokens)
    end

    def sessions
      Sessions.new(tokens: tokens)
    end

    private

    attr_reader :tokens

    class Request
      include ::HTTParty
      base_uri "http://api.sandbox.colossusbets.com/v2"
      headers "Accept" => "application/json"
    end

    class APIInterface
      def initialize(tokens: {}, request: Request)
        @tokens = tokens
        @request = request
      end

      def get(path, params = {})
        response = request.get(
          path,
          params.merge(headers: { "Authorization" => tokens['access_token'] })
        ).parsed_response

        if response.is_a?(String)
          JSON.parse(response)
        elsif response["error"]
          raise(APIError, response["error"])
        else
          response
        end
      end

      def post(path, params = {})
        request.post(
          path,
          params.merge(headers: { "Authorization" => tokens['access_token'] })
        ).parsed_response
      end

      private

      attr_reader :tokens, :request
    end

    class Sessions < APIInterface
      def create(api_key:, api_secret:)
        request.post(
          "/sessions",
          body: { api_key: api_key, api_secret: api_secret}
        )
      end
    end

    class Pools < APIInterface
      def all
        get("/pools")
      end
    end

    class Tickets < APIInterface
      def all(customer_id:)
        get("/tickets", query: { customer_id: customer_id })
      end

      def create(params)
        post("/tickets", body: params)
      end
    end
  end
end
