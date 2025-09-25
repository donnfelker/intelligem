require "ruby_llm/tool"

module Shine
  module Agent
    module Tools
      class ReadFile < RubyLLM::Tool

        description "Read the contents of a given relative file path. Use this when you want to see what's inside of a file. Do not use this with directory names."
        param :path, desc: "The relative path of a file in the working directory."

        def execute(path:)
          result = nil
          CLI::UI::Spinner.spin("Reading file: #{path}") do
            result = File.read(path)
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
