class ListingsController < ApplicationController
	before_action :set_listing, only: [:show, :update, :edit, :destroy]
  before_action :require_login, only: [:index, :new]


	def index
    @listings = Listing.all
    listings_per_page = 7
    params[:page] = 1 unless params[:page]
    first_listing = (params[:page].to_i - 1 ) * listings_per_page
    @total_pages = @listings.count / listings_per_page

		# if !signed_in?
		# 	redirect_to users_path

    # else
    if @listings.count % listings_per_page > 0
      @total_pages += 1
    end
    @listings = @listings[first_listing...(first_listing + listings_per_page)]
    # end
  end

  def search
    
    @listings = Listing.search(params[:term], fields: ["title", "location"], mispellings: {below: 5})
    listings_per_page = 7
    params[:page] = 1 unless params[:page]
    first_listing = (params[:page].to_i - 1 ) * listings_per_page
    @total_pages = @listings.count / listings_per_page


    if @listings.blank?
      redirect_to listings_path, flash: { danger: "no successful search result" }
    else
      render :index
    end
  end		


	def new
		# if !signed_in?
		# 	redirect_to users_path
		# end
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
    #to find all thr reservations under this listing
    @each_booking = @listing.reservations
    #to find out the price of listing and pass it into javascript
    @price = @listing.rental_price
    @selected_dates=[]

    @each_booking.each do |x|
      range = *(x.start_date.strftime("%Y-%m-%d")..x.end_date.strftime("%Y-%m-%d"))
      
      @selected_dates << range
    end
    
    gon.price = @price
    gon.selected_dates = @selected_dates.flatten

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




