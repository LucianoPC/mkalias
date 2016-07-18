require 'command'
require 'commands/mka'

require 'mkalias'

# Command 'mkalias remove' implementation
class Remove < Command
  def self.options_messages
    %(  remove \t $ mkalias remove [alias 1] [alias 2] ... [alias n]
  \t\t - Remove the specified alias
    )
  end

  def self.command_name
    'remove'
  end

  def self.parent
    Mka
  end

  def self.run(argv)
    CommandHelper.check_run(argv, parent)

    alias_names = ARGV[0..-1]
    removed_alias = Mkalias.remove_alias(alias_names)

    CommandHelper.check_alias_exists(alias_names, removed_alias)
    unless removed_alias.empty?
      puts 'Removed Alias:'
      removed_alias.each { |alias_name| puts "- #{alias_name}" }
      CommandHelper.check_signal
    end
  end
end
