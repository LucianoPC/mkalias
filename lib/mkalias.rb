require 'mkalias/version'
require 'set'

module Mkalias

	SIGNAL_NAME = 'USR1'
  BASHRC_PATH = "#{File.expand_path('~')}/.bashrc"

  def self.new_alias(alias_name, commands, file_path=BASHRC_PATH)
    alias_names = Mkalias.list_alias(file_path)
    return false if alias_names.include?(alias_name)

    commands = commands.join('; ') if commands.kind_of?(Array)
    commands = commands.tr('#', '$')

    function_name = "mkalias_#{alias_name}"
    bash_function = "function #{function_name}(){ #{commands}; }"
    bash_alias = "alias #{alias_name}='#{function_name}'"

    open(file_path, 'a') do |file|
      file.puts("\n")
      file.puts(bash_alias)
      file.puts(bash_function)
    end

    true
  end

  def self.list_alias(file_path=BASHRC_PATH)
    alias_names = Set.new

    alias_regex = /\bmkalias_(.*)[(]/

    alias_functions = File.foreach(file_path).grep(alias_regex)
    alias_functions.each do |function|
      result = function.match(alias_regex)
      alias_names << result.captures.first if result
    end

    alias_names.to_a
  end

  def self.show_alias(alias_names, file_path=BASHRC_PATH)
    alias_names = [alias_names] unless alias_names.kind_of?(Array)

    alias_commands = {}
    alias_names.each do |alias_name|
      alias_commands[alias_name] = Mkalias.get_alias_command(alias_name,
                                                               file_path)
    end

    alias_commands.select!{ |_, value| !value.nil? }
    return alias_commands
  end

  def self.remove_alias(alias_names, file_path=BASHRC_PATH)
    alias_names = [alias_names] unless alias_names.kind_of?(Array)

    removed_alias = []
    alias_names.each do |alias_name|
      removed = Mkalias.remove_one_alias(alias_name, file_path)
      removed_alias << alias_name if removed
    end

    return removed_alias
  end

	def self.add_signal(file_path=BASHRC_PATH)
		return false if Mkalias.has_signal?(file_path)

		trap_command = "trap 'source #{file_path}' #{SIGNAL_NAME}"
    open(file_path, 'a') do |file|
      file.puts("\n")
      file.puts(trap_command)
    end

		true
	end

	def self.remove_signal(file_path=BASHRC_PATH)
		return false unless has_signal?(file_path)

		trap_regex = /\btrap\s'source\s(.*)\sUSR1/

    lines = File.readlines(file_path).reject{ |line| line =~ trap_regex }
    File.open(file_path, "w"){ |f| lines.each { |line| f.puts line } }

		true
	end

	def self.has_signal?(file_path=BASHRC_PATH)
		trap_regex = /\btrap\s'source\s(.*)\sUSR1/
		!File.foreach(file_path).grep(trap_regex).empty?
	end

  def self.get_alias_command(alias_name, file_path=BASHRC_PATH)
    alias_names = Mkalias.list_alias(file_path)
    return nil unless alias_names.include?(alias_name)

    alias_regex = /\bmkalias_#{alias_name}[(]/
    command_regex = /[{](.*)[;]/

    alias_commands = File.foreach(file_path).grep(alias_regex)

    alias_commands.each do |command|
      result = command.match(command_regex)
        return result.captures.first.split(';').each{ |c| c.strip! } if result
    end

    nil
  end

  def self.remove_one_alias(alias_name, file_path=BASHRC_PATH)
    alias_names = Mkalias.list_alias(file_path)
    return false unless alias_names.include?(alias_name)

    alias_regex = /\bmkalias_#{alias_name}[(']/

    lines = File.readlines(file_path).reject{ |line| line =~ alias_regex }

    File.open(file_path, "w"){ |f| lines.each { |line| f.puts line } }

    return true
  end
end
