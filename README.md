# HexletCode [![Ruby](https://github.com/Kroch4ka/rails-project-63/actions/workflows/ruby.yml/badge.svg)](https://github.com/Kroch4ka/rails-project-63/actions/workflows/ruby.yml) [![hexlet-check](https://github.com/Kroch4ka/rails-project-63/actions/workflows/hexlet-check.yml/badge.svg)](https://github.com/Kroch4ka/rails-project-63/actions/workflows/hexlet-check.yml)

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/hexlet_code`. To experiment with that code, run `bin/console` for an interactive prompt.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'hexlet_code'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install hexlet_code

## Usage
```ruby
User = Struct.new(:name, :surname)
user = User.new("First", "Second")
    HexletCode.form_for user do |f|
      f.input :name
      f.input :surname, as: :text
    end

#=> <form action="#" method="POST"><input type="text" name="name" value="Nikita"><textarea cols="50" rows="50" name="surname" value="Golubev"></textarea></form>
```

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/hexlet_code.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
