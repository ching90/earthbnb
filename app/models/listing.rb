class Listing < ActiveRecord::Base
   belongs_to :user
   mount_uploaders :avatars, AvatarUploader
   has_many :reservations


	# def self.count_nights
	# 	end_date - start_date
	# end

end
