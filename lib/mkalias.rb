require 'mkalias/version'
require 'set'

# Module to manage alias
module Mkalias
  module_function

  SIGNAL_NAME = 'USR1'.freeze
  BASHRC_PATH = "#{File.expand_path('~')}/.bashrc".freeze

  def new_alias(alias_name, commands, file_path = BASHRC_PATH)
    alias_names = Mkalias.list_alias(file_path)
    return false if alias_names.include?(alias_name)

    commands = Mkalias.prepare_commands(commands)

    function_name = "mkalias_#{alias_name}"
    bash_function = "function #{function_name}(){ #{commands}; }"
    bash_alias = "alias #{alias_name}='#{function_name}'"

    open(file_path, 'a') do |file|
      file.puts("\n#{bash_alias}\n#{bash_function}")
    end

    true
  end

  def list_alias(file_path = BASHRC_PATH)
    alias_names = Set.new

    alias_regex = /mkalias_(.*?)\(/

    alias_functions = File.foreach(file_path).grep(alias_regex)
    alias_functions.each do |function|
      result = function.match(alias_regex)
      alias_names << result.captures.first if result
    end

    alias_names.to_a
  end

  def show_alias(alias_names, file_path = BASHRC_PATH)
    alias_names = [alias_names] unless alias_names.is_a?(Array)

    alias_commands = {}
    alias_names.each do |alias_name|
      alias_commands[alias_name] = Mkalias.get_alias_command(alias_name,
                                                             file_path)
    end

    alias_commands.select! { |_, value| !value.nil? }
    alias_commands
  end

  def remove_alias(alias_names, file_path = BASHRC_PATH)
    alias_names = [alias_names] unless alias_names.is_a?(Array)

    removed_alias = []
    alias_names.each do |alias_name|
      removed = Mkalias.remove_one_alias(alias_name, file_path)
      removed_alias << alias_name if removed
    end

    removed_alias
  end

  def add_signal(file_path = BASHRC_PATH)
    return false if Mkalias.signal?(file_path)

    trap_command = "trap 'source #{file_path}' #{SIGNAL_NAME}"
    open(file_path, 'a') do |file|
      file.puts("\n")
      file.puts(trap_command)
    end

    true
  end

  def remove_signal(file_path = BASHRC_PATH)
    return false unless signal?(file_path)

    trap_regex = /\btrap\s'source\s(.*)\sUSR1/

    lines = File.readlines(file_path).reject { |line| line =~ trap_regex }
    File.open(file_path, 'w') { |f| lines.each { |line| f.puts line } }

    true
  end

  def signal?(file_path = BASHRC_PATH)
    trap_regex = /\btrap\s'source\s(.*)\sUSR1/
    !File.foreach(file_path).grep(trap_regex).empty?
  end

  def get_alias_command(alias_name, file_path = BASHRC_PATH)
    alias_names = Mkalias.list_alias(file_path)
    return nil unless alias_names.include?(alias_name)

    alias_regex = /mkalias_#{alias_name}\(/
    command_regex = /[{](.*)[;]/

    alias_commands = File.foreach(file_path).grep(alias_regex)

    alias_commands.each do |command|
      result = command.match(command_regex)
      return result.captures.first.split(';').each(&:strip!) if result
    end
  end

  def remove_one_alias(alias_name, file_path = BASHRC_PATH)
    alias_names = Mkalias.list_alias(file_path)
    return false unless alias_names.include?(alias_name)

    alias_regex = /\bmkalias_#{alias_name}[(']/

    lines = File.readlines(file_path).reject { |line| line =~ alias_regex }

    File.open(file_path, 'w') { |f| lines.each { |line| f.puts line } }
  end

  def prepare_commands(commands)
    commands = commands.join('; ') if commands.is_a?(Array)
    unless commands.include?(';') || commands.include?('#')
      commands = "#{commands} $@"
    end
    commands = commands.tr('#', '$')

    commands
  end
end
