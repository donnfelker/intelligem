require "ruby_llm/tool"

module Shine
  module Agent
    module Tools
      class RunShellCommand < RubyLLM::Tool
        description "Execute a linux shell command, only use this when you cannot get the result from the read file tool, or list files tool."
        param :command, desc: "The command to execute"

        def execute(command:)
          CLI::UI.puts "AI wants to execute the following shell command: #{command}"
          confirmed = CLI::UI.confirm("Do you want to execute it?", default: false)
          return { error: "User declined to execute the command." } unless confirmed

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
