shared_context "messages support" do
  before(:each) do
    @sender = FactoryGirl.create(:user)
    @recipient = FactoryGirl.create(:user)
    @grandparents = []
    5.times do
      @grandparents << FactoryGirl.create(:message, :sender_id => @sender.id, :recipient_nickname => @recipient.nickname)
    end
    @parents = []
    4.times do |index|
      3.times do
        @parents << FactoryGirl.create(:message, :sender_id => @recipient.id, :recipient_nickname => @sender.nickname, :parent_id => @grandparents[index].id)
      end
    end
    @messages = []
    10.times do |index|
      2.times do
        @messages << FactoryGirl.create(:message, :sender_id => @sender.id, :recipient_nickname => @recipient.nickname, :parent_id => @parents[index].id)
      end
    end
  end
end
