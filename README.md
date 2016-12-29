# StatisticsCalc

Statistics gem to help with a few basic statistical calculations such as the lower bound of a Wilson score confidence interval for a Bernoulli distribution.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'statistics_calc'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install statistics_calc

## Usage

Additional paramaters are available for some functions

**CI Lower Bound of the Wilson core confidence interval for a Bernoulli distribution**

http://www.evanmiller.org/how-not-to-sort-by-average-rating.html

```ruby
StatisticsCalc.two_point_ranking(first_count: 350, second_count: 15) == 0.9335708863805254
```

**Hot Rating**

https://bibwild.wordpress.com/2012/05/08/reddit-story-ranking-algorithm

```ruby
# if Time.now = 2016-12-16 12:36:43 -0600 then
StatisticsCalc.hot(upper_value: 350, lower_value: 15) == 551.3738607329627
```

**Performance Rating**

```ruby
StatisticsCalc.performance(upper_value: 350, lower_value: 15) == 2.5250448070368448
```

**Percent Delta**

```ruby
StatisticsCalc.percent_delta(current_value: 350, old_value: 15) == 22
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/statistics_calc.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
