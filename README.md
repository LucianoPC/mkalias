# Mkalias [![Gem Version](https://badge.fury.io/rb/mkalias.svg)](https://badge.fury.io/rb/mkalias) [![Build Status](https://travis-ci.org/LucianoPC/mkalias.svg?branch=master)](https://travis-ci.org/LucianoPC/mkalias) [![Code Climate](https://codeclimate.com/github/LucianoPC/mkalias/badges/gpa.svg)](https://codeclimate.com/github/LucianoPC/mkalias)

MKalias is a gem to manage alias, when you can just add a command and you can
add a new alias, list the alias, show the alias command or remove the alias.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mkalias'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mkalias

## Usage

    run: $ mkalias [option]

		options:

     new      $ mkalias new [alias] [command 1] [command 2] ... [command n]
              - Create a new alias to run the commands

     list     $ mkalias list
              - List all alias

     show     $ mkalias show
              - Show commands of all alias

              $ mkalias show [alias 1] [alias 2] ... [alias n]
              - Show commands of the specified alias

     remove   $ mkalias remove [alias 1] [alias 2] ... [alias n]
              - Remove the specified alias

    Attention: To make alias with args use #. Example:
               $ mkalias new [alias] "echo #1 #2 #3"
               Then you can use: $ [alias] arg1 arg2 arg3


## Development

After checking out the repo, run `bin/setup` to install dependencies.
Then, run `rake spec` to run the tests. You can also run `bin/console` for
an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`.
To release a new version, update the version number in `version.rb`, and then
run `bundle exec rake release`, which will create a git tag for the version,
push git commits and tags, and push the `.gem` file
to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at
https://github.com/LucianoPC/mkalias. This project is intended to be a safe,
welcoming space for collaboration, and contributors are expected to adhere
to the [Contributor Covenant](http://contributor-covenant.org)
code of conduct.
