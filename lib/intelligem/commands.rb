require 'intelligem'

module Intelligem
  module Commands
    Registry = CLI::Kit::CommandRegistry.new(default: 'help')

    def self.register(const, cmd, path)
      autoload(const, path)
      Registry.add(->() { const_get(const) }, cmd)
    end

    register :Agent, 'agent', 'intelligem/commands/agent'
    register :Example, 'example', 'intelligem/commands/example'
    register :Help,    'help',    'intelligem/commands/help'
  end
end
