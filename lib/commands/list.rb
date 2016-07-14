require 'command'
require 'commands/mka'

require 'mkalias'

# Command 'mkalias list' implementation
class List < Command
  def self.options_messages
    %(  list \t\t $ mkalias list
  \t\t - List all alias
    )
  end

  def self.command_name
    'list'
  end

  def self.parent
    Mka
  end

  def self.run(*)
    alias_names = Mkalias.list_alias

    puts 'Registered Alias:'
    alias_names.each do |alias_name|
      puts " - #{alias_name}"
    end
  end
end
