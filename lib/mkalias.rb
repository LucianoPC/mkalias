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

  def self.show_alias(alias_name)
    alias_names = Mkalias.list_alias
    return nil unless alias_names.include?(alias_name)

    alias_regex = /\bmkalias_#{alias_name}[(]/
    function_regex = /[{](.*)[;]/

    bash_path = "#{File.expand_path('~')}/.bashrc"
    alias_functions = File.foreach(bash_path).grep(alias_regex)
    alias_functions.each do |function|
      result = function.match(function_regex)
      return result.captures.first.strip if result
    end

    nil
  end

  def self.remove_alias(alias_name)
    alias_names = Mkalias.list_alias
    return false unless alias_names.include?(alias_name)

    alias_regex = /\bmkalias_#{alias_name}[(']/

    bash_path = "#{File.expand_path('~')}/.bashrc"
    lines = File.readlines(bash_path).reject{ |line| line =~ alias_regex }

    File.open(bash_path, "w"){ |f| lines.each { |line| f.puts line } }

    return true
  end
end
