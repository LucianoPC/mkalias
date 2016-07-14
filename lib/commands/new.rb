require 'command'
require 'command_helper'
require 'commands/mka'

require 'mkalias'

# Command 'mkalias new' implementation
class New < Command
  def self.options_messages
    %(  new \t\t $ mkalias new [alias] [command 1] [command 2] ... [command n]
  \t\t - Create a new alias to run the commands
    )
  end

  def self.command_name
    'new'
  end

  def self.parent
    Mka
  end

  def self.run(argv)
    CommandHelper.check_run(argv)

    alias_name = argv[0]
    commands = argv[1..-1]
    result = Mkalias.new_alias(alias_name, commands)

    print_result(result, alias_name)
  end

  def self.print_result(result, alias_name)
    if result
      puts " - Created Alias: #{alias_name}"
      CommandHelper.check_signal
    else
      puts " ERROR: O Alias [#{alias_name}] já existe"
    end
  end
end
