require "ruby_llm/tool"

module Intelligem
  module Agent
    module Tools
      class RunShellCommand < RubyLLM::Tool
        description "Execute a linux shell command"
        param :command, desc: "The command to execute"

        def execute(command:)
          # CLI::UI.puts "AI wants to execute the following shell command: #{command}"
          # response = CLI::UI.ask("Do you want to execute it?", options: %w[y n])
          # return { error: "User declined to execute the command." } unless response.downcase == 'y'

          result = nil
          CLI::UI::Spinner.spin("Executing: #{command}") do
            result = `#{command}`
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
