# Module with Mkalias usage options
module Usage
  module_function

  def header
    %(Usage: mkalias [option]

options:
    )
  end

  def option_new
    %(  new \t\t $ mkalias new [alias] [command 1] [command 2] ... [command n]
  \t\t - Create a new alias to run the commands
    )
  end

  def option_list
    %(  list \t\t $ mkalias list
  \t\t - List all alias
    )
  end

  def option_show
    %(  show \t\t $ mkalias show
  \t\t - Show commands of all alias

  \t\t $ mkalias show [alias 1] [alias 2] ... [alias n]
  \t\t - Show commands of the specified alias
    )
  end

  def option_remove
    %(  remove \t $ mkalias remove [alias 1] [alias 2] ... [alias n]
  \t\t - Remove the specified alias
    )
  end

  def option_signals
    %(  add_signal \t $ mkalias add_signal
  \t\t - Add signal to run 'source ~/.bashrc' when
  \t\t - add or remove an alias

  remove_signal  $ mkalias remove_signal
  \t\t - Remove signal to run 'source ~/.bashrc' when
  \t\t - add or remove an alias
    )
  end

  def attention
    %(  Attention: To make alias with args use #. Example:
             $ mkalias new [alias] "echo #1 #2 #3"
             - Then you can use: $ [alias] arg1 arg2 arg3
    )
  end
end
