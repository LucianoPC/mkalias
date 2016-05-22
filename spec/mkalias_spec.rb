require 'spec_helper'

FILE_PATH = './test_bashrc'.freeze

describe Mkalias do
  it 'has a version number' do
    expect(Mkalias::VERSION).not_to be nil
  end

  describe 'test Mkalias functions' do
    before do
      File.new(FILE_PATH, 'w')

      open(FILE_PATH, 'a') do |file|
        file.puts("\n")
        file.puts("alias cd='mkalias_cd'\n")
        file.puts("function mkalias_cd(){ ls -la; }\n")
        file.puts("\n")
        file.puts("alias mv='mkalias_mv'\n")
        file.puts("function mkalias_mv(){ touch; pwd; }\n")
        file.puts("\n")
        file.puts("alias fkd='mkalias_fkd'\n")
        file.puts("function mkalias_fkd(){ flake8 $(git ls-files -m) $@; }\n")
      end
    end

    after do
      File.delete(FILE_PATH)
    end

    it 'create new alias' do
      alias_name = 'ls'
      command = 'pwd'

      Mkalias.new_alias(alias_name, command, FILE_PATH)
      lines = File.readlines(FILE_PATH)

      expect(lines).to include("alias ls='mkalias_ls'\n")
      expect(lines).to include("function mkalias_ls(){ pwd $@; }\n")
    end

    it 'create new alias with args' do
      alias_name = 'ls'
      command = 'echo #1 #2'

      Mkalias.new_alias(alias_name, command, FILE_PATH)
      lines = File.readlines(FILE_PATH)

      expect(lines).to include("alias ls='mkalias_ls'\n")
      expect(lines).to include("function mkalias_ls(){ echo $1 $2; }\n")
    end

    it 'create new alias with multiple commands' do
      alias_name = 'ls'
      commands = ['pwd', 'echo a', 'cd']

      Mkalias.new_alias(alias_name, commands, FILE_PATH)
      lines = File.readlines(FILE_PATH)

      expect(lines).to include "alias ls='mkalias_ls'\n"
      expect(lines).to include "function mkalias_ls(){ pwd; echo a; cd; }\n"
    end

    it 'dont create new alias with an existing name' do
      alias_name = 'cd'
      command = 'echo #1 #2'

      result = Mkalias.new_alias(alias_name, command, FILE_PATH)

      expect(result).to be false
    end

    it 'list all alias' do
      alias_names = Mkalias.list_alias(FILE_PATH)

      expect(alias_names).to include 'cd'
      expect(alias_names).to include 'mv'
      expect(alias_names).to include 'fkd'
    end

    it 'show alias commands' do
      alias_commands = Mkalias.show_alias(%w(cd mv fkd), FILE_PATH)

      expect(alias_commands['cd']).to include 'ls -la'
      expect(alias_commands['mv']).to include 'touch'
      expect(alias_commands['mv']).to include 'pwd'
      expect(alias_commands['fkd']).to include 'flake8 $(git ls-files -m) $@'
    end

    it 'dont show alias commands if alias not exists' do
      alias_commands = Mkalias.show_alias(['dd'], FILE_PATH)

      expect(alias_commands.keys).not_to include 'dd'
    end

    it 'remove alias' do
      removed_alias = Mkalias.remove_alias(%w(cd mv), FILE_PATH)
      alias_names = Mkalias.list_alias(FILE_PATH)

      expect(removed_alias).to include 'cd'
      expect(removed_alias).to include 'mv'
      expect(alias_names).not_to include 'cd'
      expect(alias_names).not_to include 'mv'
    end

    it 'add signal' do
      result = Mkalias.add_signal(FILE_PATH)

      expect(result).to be true
    end

    it 'dont add signal if already exists' do
      Mkalias.add_signal(FILE_PATH)
      result = Mkalias.add_signal(FILE_PATH)

      expect(result).to be false
    end

    it 'remove signal' do
      Mkalias.add_signal(FILE_PATH)
      result = Mkalias.remove_signal(FILE_PATH)

      expect(result).to be true
    end

    it 'dont remove signal unless already exists' do
      result = Mkalias.remove_signal(FILE_PATH)

      expect(result).to be false
    end
  end
end
