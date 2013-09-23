module TagsContext
  def self.included(base)
    base.class_eval do
      extend RSpec::SharedContext
      before :each do
        tagged_on_skills_user =   FactoryGirl.create(:user, :skill_list => 'reading, riting, and rithmetic')
        tagged_on_skills_dup =   FactoryGirl.create(:user, :skill_list => 'reading, riting, and rithmetic')
        tagged_on_skills_trip =   FactoryGirl.create(:user, :skill_list => 'reading, riting, and rithmetic')
        tagged_on_interests_user =   FactoryGirl.create(:user, :interest_list => 'tension, apprehension, and dissension, have-begun')
        tagged_on_hobbies_user =   FactoryGirl.create(:user, :hobby_list => 'fee, fie, foe, fum')

        tagged_group =   FactoryGirl.create(:group, :tag_list => 'reading, apprehension, fum')

        tagged_page =   FactoryGirl.create(:page, :pageable => tagged_on_skills_user, :tag_list => 'reading, apprehension, fum, have-begun')

        tagged_status =   FactoryGirl.create(:status, :user => tagged_on_skills_user, :body => 'this #aint #no #disco')

        reading_tag =   Tag.friendly.find('reading')
      end
    end
  end
end