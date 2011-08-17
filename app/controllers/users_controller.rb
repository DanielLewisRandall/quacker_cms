class UsersController < ApplicationController
  
	before_filter :authenticate,  :except => [:show, :new, :create]
	before_filter :not_signed_in, :only => [:new, :create]
	before_filter :correct_user,  :only => [:edit, :update]
	before_filter :admin_user,    :only => :destroy
	before_filter :not_self,      :only => :destroy
	
	def index
		@title = "All Quackers"
		#not paginated:
		#@users = User.all
		#paginated:
		@users = User.paginate(:page => params[:page])
	end	
	
	def show
		@user = User.find(params[:id])
		@microposts = @user.microposts.paginate(:page => params[:page])
		@title = @user.name
	end

	def new
		@user = User.new
		@title = "Sign up"
	end
	
	def create 
		@user = User.new(params[:user])
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to Quacker."
			redirect_to @user
		else
			@title = "Sign up"
			render 'new'
		end
	end

	def edit
		@title = "Edit settings"
	end
	
	def update
		if @user.update_attributes(params[:user])
			flash[:success] = "Settings updated."
			redirect_to @user
		else
			@title = "Edit settings"
			render 'edit'
		end
	end
	
	def destroy
			User.find(params[:id]).destroy
			flash[:success] = "Quacker destroyed."
			redirect_to users_path
	end
	
	def following
	  @title = "Following"
	  @user = User.find(params[:id])
	  @users = @user.following.paginate(:page => params[:page])
	  render 'show_follow' # TODO: render "unfollow/follow" buttons in list
	end
	
	def followers
	  @title = "Followers"
	  @user = User.find(params[:id])
	  @users = @user.followers.paginate(:page => params[:page])
	  render 'show_follow' # TODO: render "unfollow/follow" buttons in list
	end
	
	private

		def correct_user
			@user = User.find(params[:id])
			redirect_to(root_path) unless current_user?(@user)
		end
		
		def admin_user
			redirect_to(root_path) unless current_user.admin?
		end

		def not_self
			#protects admin user from self-deletion:
			if current_user?(User.find(params[:id]))
				redirect_to(users_path)
			end
		end
		
		def not_signed_in
			#prevents signed in user from accessing new or create:
			if signed_in?
				redirect_to(users_path)
			end
		end

end
