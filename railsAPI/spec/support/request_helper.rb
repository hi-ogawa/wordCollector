module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end
  end

  module HeaderHelpers
    def api_header(version = 1)
      request.headers['Accept'] = "application/vnd.railsAPI.v#{version}"
    end

    def api_response_format
      request.headers['Content-Type'] = Mime::JSON.to_s
    end

    def include_default_accept_headers
      api_header
      api_response_format
    end
  end
end
