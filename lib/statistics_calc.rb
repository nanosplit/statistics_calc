require "statistics_calc/version"
include Math

$epoch = Time.local(1970, 01, 01, 00, 00, 00).to_time

module StatisticsCalc

  # compares two numbers and returns the CI lower bound of the Wilson core confidence interval for a Bernoulli distribution
  # set zval to 1.96 by default - can provide different value based on desired confidence level
  # Use:
  # StatisticsCalc.two_point_ranking(350, 15) = 0.9335708863805254
  def StatisticsCalc.two_point_ranking(first_count = 0, second_count = 0, zval = 1.96)
    z2  = zval**2
    zsq = (zval/2)**2
    zf  = zsq * 2

    ci_lower_bound = ((first_count + zf) / (first_count + second_count) -
    zval * sqrt((first_count * second_count) / (first_count + second_count) + zsq) /
    (first_count + second_count)) / (1 + z2 / (first_count + second_count))

    return ci_lower_bound
  end

  # Hot Calculator
  # Provides a score based on the logarithm of an upper and lower value with time decay
  # Date provides a scale that increases the value of the most recent objects
  # Epoch defaults to Unix epoch, but can be provided if you want a different time scale
  # Decay can speed up (lower #) or slow down (higher #) the rate of decay
  # Decay time is in seconds, default 2700000 = month in seconds
  # Based on https://bibwild.wordpress.com/2012/05/08/reddit-story-ranking-algorithm
  # Use:
  # if Time.now = 2016-12-16 12:36:43 -0600 then StatisticsCalc.hot(350, 15) = 551.3738607329627
  def StatisticsCalc.hot(upper_value, lower_value, date = Time.now, epoch = $epoch, decay = 2700000)
    return performance(upper_value, lower_value) + (epoch_seconds(date, epoch) / decay)
  end

  # Use:
  # StatisticsCalc.performance(350, 15) = 2.5250448070368448
  def StatisticsCalc.performance(upper_value = 0, lower_value = 0)
    difference = upper_value - lower_value
    displacement  = displacement(upper_value, lower_value)

    # ensure we're working with positive numbers to avoid negative scores
    equalizer = if difference > 0
                  1
                elsif difference < 0
                  -1
                else
                  0
                end

    return (displacement * equalizer.to_f)
  end

  # calculates the percent delta of two values
  # provide the new value and old value to compare
  # Use:
  # StatisticsCalc.percent_delta(350, 15) = 22
  def StatisticsCalc.percent_delta(current_value = 0, old_value = 0)
    (current_value - old_value) / old_value
  rescue Exception => e
    return "#{e.class} - You can't divide by zero! current_value: #{current_value} old_value: #{old_value}"
  end

  private

  # determine the time in seconds since epoch
  def self.epoch_seconds(date = Time.now, epoch = $epoch)
    (date.to_i - epoch.to_i).to_f
  end

  def self.displacement(upper_value = 0, lower_value = 0)
    difference    = upper_value - lower_value
    log([difference.abs, 1].max, 10)
  end

end
