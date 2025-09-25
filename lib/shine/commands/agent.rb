require 'shine'
require 'ruby_llm'
require_relative '../agent/agent'

module Shine
  module Commands
    class Agent < Shine::Command
      def call(_args, _name)
        api_key = ENV['ANTHROPIC_API_KEY']

        unless api_key
          CLI::UI.puts "{{red:Error: ANTHROPIC_API_KEY environment variable is not set}}"
          CLI::UI.puts ""
          CLI::UI.puts "Please set your Anthropic API key using one of these methods:"
          CLI::UI.puts "  1. Create a .env file with: ANTHROPIC_API_KEY=your-api-key-here"
          CLI::UI.puts "  2. Export it: export ANTHROPIC_API_KEY='your-api-key-here'"
          CLI::UI.puts ""
          CLI::UI.puts "You can get an API key from: https://console.anthropic.com/account/keys"
          return
        end

        RubyLLM.configure do |config|
          config.anthropic_api_key = api_key
          # Using a standard Claude model name
          config.default_model = 'claude-sonnet-4-20250514'
        end

        agent = Shine::Agent::Agent.new
        agent.run
      end

      def self.help
        "Start the AI coding agent.\nUsage: {{command:#{Shine::TOOL_NAME} agent}}"
      end
    end
  end
end