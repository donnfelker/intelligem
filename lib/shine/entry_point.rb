require 'shine'

module Shine
  module EntryPoint
    def self.call(args)
      cmd, command_name, args = Shine::Resolver.call(args)
      Shine::Executor.call(cmd, command_name, args)
    end
  end
end
