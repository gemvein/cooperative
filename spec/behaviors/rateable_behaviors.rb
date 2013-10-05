RSpec::Matchers.define :be_rateable do
  define_method :rateable_ids do |actual|
    actual.map{|x| x[:id] if was_rated?(x)}.compact
  end

  define_method :unrateable_ids do |actual|
    actual.map{|x| x[:id] unless was_rated?(x)}.compact
  end

  define_method :is_rateable? do |actual|
    actual.click_link actual.find('.up')[:id]
    was_rated? actual
  end

  define_method :was_rated? do |actual|
    actual.click_link :vote.l
    actual.has_content? 'You voted up on this status'
  end

  match do |rateable|
    if rateable.is_a? Capybara::Result
      rateable.all? { |member| is_rateable? member }
    else
      puts rateable.class.name
      is_rateable? rateable
    end
  end

  failure_message_for_should do |rateable|
    if rateable.is_a? Capybara::Result
      "expected #{unrateable_ids(rateable) * ', '} to be rateable"
    else
      "expected #{rateable[:id]} to be rateable"
    end
  end

  failure_message_for_should_not do |rateable|
    if rateable.is_a? Capybara::Result
      "expected #{rateable_ids(rateable) * ', '} to not be rateable"
    else
    "expected #{rateable[:id]} to not be rateable"
    end
  end
end