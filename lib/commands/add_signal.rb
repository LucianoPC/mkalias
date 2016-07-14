require 'command'
require 'commands/mka'

require 'mkalias'

# Command 'mkalias add_signal' implementation
  class AddSignal < Command
  def self.options_messages
    %(  add_signal \t $ mkalias add_signal
  \t\t - Add signal to run 'source ~/.bashrc' when
  \t\t - add or remove an alias
    )
  end

  def self.command_name
    'add_signal'
  end

  def self.parent
    Mka
  end

  def self.run(*)
    result = Mkalias.add_signal

    if result
      puts "Add signal to call 'source ~/.bashrc'"
      puts " - Run '$ source ~/.bashrc' to update your bash"
    else
      puts 'The signal has already been added'
    end
  end
end
