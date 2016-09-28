# Preview all emails at http://localhost:3000/rails/mailers/reservation_mailer
class ReservationMailerPreview < ActionMailer::Preview
	# def notification_email_preview
	# 	ReservationMailer.notification_email("sooching4896@gmail.com", "sooching4896@gmail.com",2, 1)
	# end


	def notification_email_preview
		ReservationMailer.notification_email("sooching4896@gmail.com", "sooching4896@gmail.com",1,2)
	end



end
