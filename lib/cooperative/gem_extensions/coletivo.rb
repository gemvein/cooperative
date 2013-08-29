module Cooperative
  module Models
    module Ratings

      def acts_as_rateable
        class_eval do
          has_many :ratings, :as => :rateable

          def has_been_rated_by?(rater)
            ratings.where("rater_type = ? AND rater_id = ?", rater.class.name, rater.id).count > 0
          end
        end
      end
    end
  end
end

