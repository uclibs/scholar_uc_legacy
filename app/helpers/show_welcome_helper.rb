module ShowWelcomeHelper

	def show_welcome_page
		if current_user.present? && current_user.ucstatus == "Student"
			render "student_welcome_text"
		else
			render "welcome_text"
		end
	end

end