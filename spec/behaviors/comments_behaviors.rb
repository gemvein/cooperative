RSpec::Matchers.define :be_commentable do
  define_method :is_commentable? do |actual|
    actual.fill_in 'comment[body]', :with => 'I had a rooster and the rooster pleased me.'
    actual.click_button :comment.l
    actual.has_selector? '.comment p', :text => 'I had a rooster and the rooster pleased me.'
  end

  match do |commentable|
    if commentable.is_a? Capybara::Result
      !commentable.any? { |member| !is_commentable? member }
    else
      is_commentable? commentable
    end
  end

  failure_message_for_should do |commentable|
    if commentable.is_a? Capybara::Result
      "expected #{commentable.map { |x| x[:id] } * ', '} to be commentable"
    else
      "expected #{commentable.class.name} #{commentable.id.to_s} to be commentable"
    end
  end

  failure_message_for_should_not do |commentable|
    if commentable.is_a? Capybara::Result
      "expected #{commentable.map { |x| x[:id] } * ', '} to not be commentable"
    else
      "expected #{commentable.class.name} #{commentable.id.to_s} to not be commentable"
    end
  end
end