require "ruby_llm/tool"
require 'net/http'
require 'uri'

module Shine
  module Agent
    module Tools
      class FetchUrl < RubyLLM::Tool
        description <<~DESCRIPTION
          Fetches content from a given URL and returns the response body as text.
          Handles HTTP GET requests and returns the response content or an error message if the request fails.
        DESCRIPTION

        param :url, desc: "The URL to fetch content from"

        def execute(url:)
          result = nil
          CLI::UI::Spinner.spin("Fetching URL: #{url}") do
            uri = URI(url)
            response = Net::HTTP.get_response(uri)
            
            result = if response.is_a?(Net::HTTPSuccess)
              response.body
            else
              "Error: #{response.code} - #{response.message}"
            end
          end
          result
        rescue => e
          CLI::UI.puts e.message
          { error: e.message }
        end
      end
    end
  end
end