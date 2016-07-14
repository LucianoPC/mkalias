# Abstract class with definitions of commands
class Command
  def self.options_messages
    raise 'return a list with how to use this command'
  end

  def self.command_name
    raise 'return the command name'
  end

  def self.run(argv)
    run_childrens(argv)
  end

  def self.parent
    nil
  end

  def self.childrens
    []
  end

  def self.childrens?
    !childrens.empty?
  end

  def self.usage_bottom
    ''
  end

  def self.run_childrens(argv)
    children_command = argv.first
    children = childrens.detect { |c| c.command_name == children_command }
    return usage unless children

    argv.delete(children.command_name)
    children.run(argv)
  end

  def self.usage
    usage_message = usage_header
    usage_message += "\n\n[options]\n"

    childrens.each do |command|
      messages = command.options_messages
      messages = [messages] unless messages.is_a?(Array)

      messages.each do |message|
        usage_message += "\n#{message}" if message
      end
    end

    puts usage_message + "\n#{usage_bottom}"
  end

  def self.usage_header
    header = ''
    header += '[option]' if childrens?
    header = "#{command_name} " + header

    parent = self.parent
    until parent.nil?
      header = "#{parent.command_name} " + header
      parent = parent.parent
    end

    header = '$ ' + header
    header
  end
end
