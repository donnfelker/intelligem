require 'ruby_llm'
require_relative "tools/read_file"
require_relative "tools/list_files"
require_relative "tools/edit_file"
require_relative "tools/run_shell_command"
require_relative "tools/fetch_url"

module Shine
  module Agent
    class Agent
      def initialize
        # Chat will be initialized when run is called
        @chat = nil
      end

      def run
        # Initialize chat with tools when run is called
        @chat = RubyLLM.chat

        

        @chat = @chat.with_tools(
          Shine::Agent::Tools::ReadFile,
          Shine::Agent::Tools::ListFiles,
          Shine::Agent::Tools::EditFile,
          Shine::Agent::Tools::FetchUrl,
          Shine::Agent::Tools::RunShellCommand
        )

        CLI::UI.puts "Chat with the agent. Type 'exit' to quit"
        loop do
          user_input = CLI::UI.ask("What can I help you with?")
          break if user_input.nil? || user_input.downcase == 'exit'

          next if user_input.strip.empty? # Skip empty inputs


          begin
            last_was_content = false

            @chat.ask(user_input) do |chunk|
              CLI::UI.raw do
                if chunk.content && !chunk.content.empty?
                  $stdout.write(chunk.content)
                  last_was_content = true
                elsif chunk.tool_calls&.any? && last_was_content
                  # Add newline before tool call if we just printed content
                  CLI::UI.puts ""
                  last_was_content = false
                end
              end
            end

          rescue => e
            CLI::UI.puts "{{red:Error: #{e.message}}}"
            CLI::UI.puts "{{yellow:Stack trace:}}" if ENV['DEBUG']
            CLI::UI.puts e.backtrace.join("\n") if ENV['DEBUG']
          end
          
            
        end
      end
    end
  end
end
