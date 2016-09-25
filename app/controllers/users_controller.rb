class UsersController < Clearance::UsersController
	before_action :set_user, only: [:show, :update, :edit, :destroy]

  def index
	end
    
  def show
    @user_reserved=Reservation.where(user_id: @user.id)
  end

  def new
     @user = User.new
  end

  def create
  	@user = User.new(user_params)
     if @user.save
	  redirect_to user_path(@user.id)
     else
       render 'index'
     end
  end

  def edit
  end

	def update
	  @user.update(user_params)
	  redirect_to user_path(@user.id)
	end

  private
  
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, {avatars:[]})
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
