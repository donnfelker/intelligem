require 'intelligem'

module Intelligem
  module EntryPoint
    def self.call(args)
      cmd, command_name, args = Intelligem::Resolver.call(args)
      Intelligem::Executor.call(cmd, command_name, args)
    end
  end
end
