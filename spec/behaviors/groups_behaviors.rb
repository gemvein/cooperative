module CapybaraNodeExtensions
  def groups
    all('.group')
  end
end

RSpec::Matchers.define :be_joinable do
  define_method :joinable_ids do |actual|
    actual.map{|x| x[:id] if was_joined?(x)}.compact
  end

  define_method :unjoinable_ids do |actual|
    actual.map{|x| x[:id] unless was_joined?(x)}.compact
  end

  define_method :is_joinable? do |actual|
    actual.click_link ' ' + :join_group.l
    was_joined? actual
  end

  define_method :was_joined? do |actual|
    actual.has_selector? 'a', :text => /#{:leave_group.l}$/
  end

  match do |group|
    if group.is_a? Capybara::Result
      !group.any? { |member| !is_joinable? member }
    else
      is_joinable? group
    end
  end

  failure_message_for_should do |joinable|
    if joinable.is_a? Capybara::Result
      "expected #{unjoinable_ids(joinable) * ', '} to be joinable"
    else
      "expected #{joinable[:id]} to be joinable"
    end
  end

  failure_message_for_should_not do |joinable|
    if joinable.is_a? Capybara::Result
      "expected #{joinable_ids(joinable) * ', '} to not be joinable"
    else
      "expected #{joinable[:id]} to not be joinable"
    end
  end
end

RSpec::Matchers.define :be_leaveable do
  define_method :leaveable_ids do |actual|
    actual.map{|x| x[:id] if was_left?(x)}.compact
  end

  define_method :unleaveable_ids do |actual|
    actual.map{|x| x[:id] unless was_left?(x)}.compact
  end

  define_method :is_leaveable? do |actual|
    actual.click_link ' ' + :join_group.l
    actual.click_link ' ' + :leave_group.l
    was_left? actual
  end

  define_method :was_left? do |actual|
    actual.has_selector? 'a', :text => /#{:join_group.l}$/
  end

  match do |group|
    if group.is_a? Capybara::Result
      !group.any? { |member| !is_leaveable? member }
    else
      is_leaveable? group
    end
  end

  failure_message_for_should do |leaveable|
    if leaveable.is_a? Capybara::Result
      "expected #{unleaveable_ids(leaveable) * ', '} to be leaveable"
    else
      "expected #{leaveable[:id]} to be leaveable"
    end
  end

  failure_message_for_should_not do |leaveable|
    if leaveable.is_a? Capybara::Result
      "expected #{leaveable_ids(leaveable) * ', '} to not be leaveable"
    else
      "expected #{leaveable[:id]} to not be leaveable"
    end
  end
end