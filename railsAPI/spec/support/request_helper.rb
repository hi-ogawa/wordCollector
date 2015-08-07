module Request
  module JsonHelpers
    def json_response
      @json_response ||= JSON.parse(response.body, symbolize_names: true)
    end

    def symbolized_json(model)
      JSON.parse(model.to_json, symbolize_names: true)
    end
  end

  module HeaderHelpers
    def header_accept_version(version = 1)
      request.headers['Accept'] = "#{request.headers['Accept']},application/vnd.railsAPI.v#{version}"
    end

    def header_content_type_json
      request.headers['Accept'] = "#{request.headers['Accept']},application/json"
      request.headers['Content-Type'] = Mime::JSON.to_s
    end
  end

  module AuthHelpers
    def header_authorization(token)
      request.headers["Authorization"] = token
    end
  end
end
