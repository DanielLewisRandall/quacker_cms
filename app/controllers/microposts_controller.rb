class MicropostsController <ApplicationController
	
	before_filter :authenticate, :only => [:create, :destroy]
	before_filter :stay_on_page, :only => :destroy
	before_filter :authorized_user, :only => :destroy
	
	def create
		@micropost = current_user.microposts.build(params[:micropost])
		if @micropost.save
			flash[:success] = "Quacked!"
			redirect_to root_path
		else
			@feed_items = []
			render 'pages/home'
		end
	end
	
	def destroy
	  @micropost.destroy
	  redirect_to :back
	end
	
	def stay_on_page
	  request.env['HTTP_REFERER'] ||= root_url
	end  
	
	private
	
	  def authorized_user
	    @micropost = Micropost.find(params[:id])
	    if (!current_user.admin? && !current_user?(@micropost.user))
	      redirect_to root_path
      end
	  end
	
end