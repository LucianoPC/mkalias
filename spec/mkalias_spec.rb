require 'spec_helper'

FILE_PATH = './test_bashrc'

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
        file.puts("function mkalias_mv(){ touch; }\n")
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
      expect(lines).to include("function mkalias_ls(){ pwd; }\n")
    end

    it 'create new alias with args' do
      alias_name = 'ls'
      command = 'echo #1 #2'

      Mkalias.new_alias(alias_name, command, FILE_PATH)
      lines = File.readlines(FILE_PATH)

      expect(lines).to include("alias ls='mkalias_ls'\n")
      expect(lines).to include("function mkalias_ls(){ echo $1 $2; }\n")
    end

    it 'list all alias' do
      alias_names = Mkalias.list_alias(FILE_PATH)

      expect(alias_names).to include('cd')
      expect(alias_names).to include('mv')
    end

    it 'show alias commands' do
      alias_cd = Mkalias.show_alias('cd', FILE_PATH)
      alias_mv = Mkalias.show_alias('mv', FILE_PATH)

      expect(alias_cd).to eq "ls -la"
      expect(alias_mv).to eq "touch"
    end

    it 'remove alias' do
      removed_cd = Mkalias.remove_alias('cd', FILE_PATH)
      removed_mv = Mkalias.remove_alias('mv', FILE_PATH)

      expect(removed_cd).to be true
      expect(removed_mv).to be true
    end
  end
end
