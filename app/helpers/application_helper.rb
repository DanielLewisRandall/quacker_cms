module ApplicationHelper

	# return the logo:
	def logo
		image_tag(
			"logo.png", 
			:alt => "Quacker", 
			:class => "round")
	end

	# Return a title on a per-page basis:
	def title

		base_title = "Quacker"

		if @title.nil?
			base_title
		else
			"#{base_title} | #{@title}"
		end

	end

end
