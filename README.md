# WhereIs

where-is-rails allows us to write rails where queries using standard ruby _CODE!_

This is a WIP/proof of concept/bad idea gem, beware using this in a production environment.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'where-is-rails'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install where-is-rails

## Usage

Where you may use:

```
  User.where("created_at > ?", 1.day.ago)
```

You can instead use:

```
  User.where.is{created_at > 1.day.ago}
```

Or where you may use:

```
  User.where("name LIKE '%Sam%'")
```

You can instead use:

```
  User.where.is{name =~ 'Sam'}
```

And the best part is, it uses Arel so we can leverage all the usual Arel benefits.

other methods include:

```
>
>=
<
<=
==
!=
=~
in?
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/hoppelite/where-is-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/hoppelite/where-is-rails/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the WhereIs project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/hoppelite/where-is-rails/blob/master/CODE_OF_CONDUCT.md).
