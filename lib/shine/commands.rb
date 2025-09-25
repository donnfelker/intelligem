require 'shine'

module Shine
  module Commands
    Registry = CLI::Kit::CommandRegistry.new(default: 'agent')

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register :Agent, 'agent', 'shine/commands/agent'
    register :Example, 'example', 'shine/commands/example'
    register :Help,    'help',    'shine/commands/help'
  end
end
