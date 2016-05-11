require "mkalias/version"

module Mkalias

  def self.new_alias(alias_name, command)
    bash_path = "#{File.expand_path('~')}/.bashrc"

    bash_line = "alias #{alias_name}='#{command}'"
    open(bash_path, 'a') do |file|
        file.puts(bash_line)
    end
  end
end
