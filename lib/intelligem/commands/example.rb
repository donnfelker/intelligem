require 'intelligem'

module Intelligem
  module Commands
    class Example < Intelligem::Command
      def call(_args, _name)
        puts 'neato'

        if rand < 0.05
          raise(CLI::Kit::Abort, "you got unlucky!")
        end
      end

      def self.help
        "A dummy command.\nUsage: {{command:#{Intelligem::TOOL_NAME} example}}"
      end
    end
  end
end
