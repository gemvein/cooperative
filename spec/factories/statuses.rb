# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :status do
    body "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam non leo sagittis urna gravida mollis. Integer non felis diam. Ut at orci et neque ullamcorper porta semper sit amet orci. Sed fringilla magna ut urna eleifend sit amet fringilla velit mollis. Vestibulum pretium, nisl sed facilisis tempus, ligula justo molestie justo, quis egestas mauris nunc in ligula. Integer placerat auctor consectetur. Mauris id ligula nunc, sed pharetra nisl."
    user_id nil
    public true
  end
end
