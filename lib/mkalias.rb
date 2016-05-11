require 'mkalias/version'
require 'set'

module Mkalias

  def self.new_alias(alias_name, command)
    command = command.gsub('#', '$')

    function_name = "mkalias_#{alias_name}"
    bash_function = "function #{function_name}(){ #{command}; }"
    bash_alias = "alias #{alias_name}='#{function_name}'"

    bash_path = "#{File.expand_path('~')}/.bashrc"
    open(bash_path, 'a') do |file|
      file.puts("\n")
      file.puts(bash_alias)
      file.puts(bash_function)
    end
  end

  def self.list_alias
    alias_names = Set.new

    alias_regex = /\bmkalias_(.*)[(]/

    bash_path = "#{File.expand_path('~')}/.bashrc"
    alias_functions = File.foreach(bash_path).grep(alias_regex)
    alias_functions.each do |function|
      result = function.match(alias_regex)
      alias_names << result.captures.first if result
    end

    alias_names.to_a
  end
end
