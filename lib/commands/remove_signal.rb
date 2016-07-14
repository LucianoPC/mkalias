require 'command'
require 'commands/mka'

require 'mkalias'

# Command 'mkalias add_signal' implementation
  class RemoveSignal < Command
  def self.options_messages
    %(  remove_signal  $ mkalias remove_signal
  \t\t - Remove signal to run 'source ~/.bashrc' when
  \t\t - add or remove an alias
    )
  end

  def self.command_name
    'remove_signal'
  end

  def self.parent
    Mka
  end

  def self.run(*)
    result = Mkalias.remove_signal

    if result
      puts 'The signal was removed'
      puts " - Run '$ source ~/.bashrc' to update your bash"
    else
      puts 'The signal does not exist to be removed'
    end
  end
end
