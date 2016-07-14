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
    check_run(argv)

    alias_name = argv[0]
    commands = argv[1..-1]
    result = Mkalias.new_alias(alias_name, commands)

    print_result(result, alias_name)
  end

  def self.print_result(result, alias_name)
    if result
      puts " - Created Alias: #{alias_name}"
      check_signal
    else
      puts " ERROR: O Alias [#{alias_name}] já existe"
    end
  end

  def self.check_run(argv)
    if argv.empty?
      parent.usage
      abort
    end
  end

  def self.check_signal
    if Mkalias.signal?
      `kill -USR1 #{Process.ppid}`
    else
      puts " - Run '$ source ~/.bashrc' to use your alias"
    end
  end
end
