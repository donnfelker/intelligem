require 'ruby_llm'
require_relative "tools/read_file"
require_relative "tools/list_files"
require_relative "tools/edit_file"
require_relative "tools/run_shell_command"
require_relative "tools/fetch_url"

module Intelligem
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
          Intelligem::Agent::Tools::ReadFile,
          Intelligem::Agent::Tools::ListFiles,
          Intelligem::Agent::Tools::EditFile,
          Intelligem::Agent::Tools::FetchUrl,
          # Intelligem::Agent::Tools::RunShellCommand
        )

        CLI::UI.puts "Chat with the agent. Type 'exit' to quit"
        loop do
          user_input = CLI::UI.ask("What can I help you with?")
          break if user_input.nil? || user_input.downcase == 'exit'

          next if user_input.strip.empty? # Skip empty inputs


          begin
            @chat.ask(user_input) do |chunk|
              CLI::UI.raw do
                $stdout.write(chunk.content) unless chunk.content.nil?
              end
              # print chunk.content unless chunk.content.nil?
            end
            puts "" # New line after response
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
