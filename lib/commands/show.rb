require 'command'
require 'commands/mka'

require 'mkalias'

# Command 'mkalias show' implementation
class Show < Command
  def self.options_messages
    %(  show \t\t $ mkalias show
  \t\t - Show commands of all alias

  \t\t $ mkalias show [alias 1] [alias 2] ... [alias n]
  \t\t - Show commands of the specified alias
    )
  end

  def self.command_name
    'show'
  end

  def self.parent
    Mka
  end

  def self.run(argv)
    alias_names = Mkalias.list_alias

    puts 'Registered Alias:'
    alias_names.each do |alias_name|
      puts " - #{alias_name}"
    end
  end

  def self.check_alias_exists(alias_list, used_alias_names)
    alias_not_founded = alias_list - used_alias_names
    unless alias_not_founded.empty?
      alias_not_founded = alias_not_founded.join(', ')
      puts "Alias not founded: #{alias_not_founded}"
      puts ''
    end
  end
end
