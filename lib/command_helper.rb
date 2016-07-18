# Module to help commands
module CommandHelper
  module_function

  def check_run(argv, parent)
    if argv.empty?
      parent.usage
      exit(-1)
      false
    end
    true
  end

  def check_signal
    if Mkalias.signal?
      `kill -USR1 #{Process.ppid}`
    else
      puts " - Run '$ source ~/.bashrc' to use your alias"
    end
  end
end
