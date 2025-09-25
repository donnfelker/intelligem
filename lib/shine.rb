require 'cli/ui'
require 'cli/kit'

CLI::UI::StdoutRouter.enable

module Shine
  TOOL_NAME = 'shine'
  ROOT      = File.expand_path('../..', __FILE__)
  LOG_FILE  = '/tmp/shine.log'

  autoload(:EntryPoint, 'shine/entry_point')
  autoload(:Commands,   'shine/commands')

  Config = CLI::Kit::Config.new(tool_name: TOOL_NAME)
  Command = CLI::Kit::BaseCommand

  Executor = CLI::Kit::Executor.new(log_file: LOG_FILE)
  Resolver = CLI::Kit::Resolver.new(
    tool_name: TOOL_NAME,
    command_registry: Shine::Commands::Registry
  )

  ErrorHandler = CLI::Kit::ErrorHandler.new(log_file: LOG_FILE)
end
