require 'command'
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
    puts 'NEW'
    # usage if argv.count < 2

    # alias_name = argv[0]
    # commands = argv[1..-1]
    # result = Mkalias.new_alias(alias_name, commands)

    # if result
    #   puts " - Created Alias: #{alias_name}"
    #   check_signal
    # else
    #   puts " ERROR: O Alias [#{alias_name}] já existe"
    # end
  end
end
