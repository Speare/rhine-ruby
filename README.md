# Rhine

This is a simple Rhine ruby library. 

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'rhine'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rhine

## Usage

```
client = Rhine::Instance.new(<APIKEY>)
puts client.run (Rhine::Functions.distance Rhine::Datatypes.entity("dog"), Rhine::Datatypes.entity("cat"))
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment. 

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).