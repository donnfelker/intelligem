require "ruby_llm/tool"

module Shine
  module Agent
    module Tools
      class ListFiles < RubyLLM::Tool
        description "List files and directories at a given path. If no path is provided, list files in the current directory."
        param :path, desc: "Optinal relative path to lis files from. Defaults to the current directory if not provided."
      
        
        def execute(path: "")
          result = nil
          CLI::UI::Spinner.spin("Listing files in: #{path.empty? ? 'current directory' : path}") do
            result = Dir.glob(File.join(path, "*")).map { |filename| File.directory?(filename) ? "#{filename}/" : filename }
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
