class UsersController < Clearance::UsersController
	def index
	end
    
    def show
    	@user = User.find(params[:id])
    end

    def new
       @user = User.new
    end

    def create
    	@user = User.new(user_params)
       if @user.save
		  redirect_to users_path
       else
         render 'index'
       end
    end

    def edit
      @user = User.find(params[:id])
    end

	def update
      user = User.find(params[:id])

	  user.update(user_params)
	  redirect_to users_path
	end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  # def user_from_params
  #   email = user_params.delete(:email)
  #   password = user_params.delete(:password)
  #   name = user_params.delete(:name)

  #   Clearance.configuration.user_model.new(user_params).tap do |user|
  #     user.email = email
  #     user.password = password
  #     user.name = password
  #   end
  # end
end
