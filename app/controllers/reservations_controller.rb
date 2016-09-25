class ReservationsController < ApplicationController
	# before_action :check_dates, only:[:create]


  def new
    @reservation= Reservation.new(reservation_params)
  end


  # def check_dates
  # 	@listing = Listing.find(params[:listing_id])
  #   @reservation = @listing.reservations.new(reservation_params)

  # end

  def create
    @listing = Listing.find(params[:listing_id])
    @reservation = @listing.reservations.new(reservation_params)

    #fill in for user_id in new reservation
    @reservation.user_id = current_user.id 

    if @reservation.start_date <= Date.today

    	@reservation = Reservation.new
    	@booked_date = Reservation.where(listing_id: params[:id])

    	flash[:error] = "Date not available"
 		render 'listings/show'
 		

    elsif @reservation.save

      	redirect_to listing_path(@listing.id)
    
    else
      render 'show'
    end
  end

  def destroy
  	
  	@reservation = Reservation.find(params[:id])

  	if @reservation.delete

  		redirect_to user_path(@reservation.user_id)
  	else
  		render 'users/show'
  	end

  end

  private

  def reservation_params
    params.require(:reservation).permit(:totalprice, :start_date, :end_date, :user_id, :listing_id)
  end
end
