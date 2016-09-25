class ListingsController < ApplicationController
	before_action :set_listing, only: [:show, :update, :edit, :destroy]

	def index
		if !signed_in?
			redirect_to users_path

    else
      @listing = Listing.all
      listings_per_page = 7
      params[:page] = 1 unless params[:page]
      first_listing = (params[:page].to_i - 1 ) * listings_per_page
      listings = Listing.all
      @total_pages = listings.count / listings_per_page
      
      if listings.count % listings_per_page > 0
        @total_pages += 1
      end
        @listings = listings[first_listing...(first_listing + listings_per_page)]
    end
  end
		


	def new
		if !signed_in?
			redirect_to users_path
		end
		@listing = Listing.new
	end
	

	def create
    	@listing = current_user.listings.new(listing_params)
       if @listing.save 
		  redirect_to listing_path(@listing.id)
       else
         render 'index'
       end
  end


  def show
    @reservation = Reservation.new
    @booked_date = Reservation.where(listing_id: params[:id])
    @each_booking = @listing.reservations
    #to find out the price of listing and pass it into javascript
    @price = @listing.rental_price
    gon.price = @price

    @selected_dates=[]

    @each_booking.each do |x|
      @selected_dates << x.start_date.strftime("%Y-%m-%d")
      while x.start_date != x.end_date
       @selected_dates << (x.start_date += 1).strftime("%Y-%m-%d")
      end

    end

    gon.selected_dates = @selected_dates

  end

  def edit
  end

  def update
    @listing.update(listing_params)
    redirect_to listing_path(@listing.id)
  end

  def destroy
    	listing = @listing.delete
    	redirect_to listings_path
  end

  private
  def set_listing
  	@listing = Listing.find(params[:id])
  end

  def listing_params
    	params.require(:listing).permit(:title, :kind_of_place, :types_of_property, :rental_price, :location, :description, :photo, :bed, :guest_allowed, :bathroom, :safety_amenities, :user_id, {avatars:[]})
	end

end



  # 		listings GET    /listings(.:format)                     listings#index
  #                  POST   /listings(.:format)                     listings#create
  #      new_listing GET    /listings/new(.:format)                 listings#new
  #     edit_listing GET    /listings/:id/edit(.:format)            listings#edit
  #          listing GET    /listings/:id(.:format)                 listings#show
  #                  PATCH  /listings/:id(.:format)                 listings#update
  #                  PUT    /listings/:id(.:format)                 listings#update
  #                  DELETE /listings/:id(.:format)                 listings#destroy




