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
    check_run(argv)

    alias_names = ARGV[0..-1]
    removed_alias = Mkalias.remove_alias(alias_names)

    check_alias_exists(alias_names, removed_alias)
    unless removed_alias.empty?
      puts 'Removed Alias:'
      removed_alias.each { |alias_name| puts "- #{alias_name}" }
      check_signal
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

  def self.check_alias_exists(alias_list, used_alias_names)
    alias_not_founded = alias_list - used_alias_names
    unless alias_not_founded.empty?
      alias_not_founded = alias_not_founded.join(', ')
      puts "Alias not founded: #{alias_not_founded}"
      puts ''
    end
  end
end
