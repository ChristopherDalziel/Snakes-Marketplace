class ListingsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_listing, only: [ :show ]
  before_action :set_user_listing, only: [ :show, :edit, :update, :destroy ]

  def index
      #Listing.all will show ALL of the snakes despite whoever is logged in.
      @listings = Listing.all
      # listing = current_user.listing will show ONLY the snakes created by the current logged
      # @listings = current_user.listings
  end

  def show
    session = Stripe::Checkout::Session.create(
      payment_method_types: [ 'card' ],
      customer_email: current_user.email,
      line_items: [{
        name: @listing.title,
        description: @listing.description, 
        amount: @listing.deposit * 100,
        currency: 'aud',
        quantity: 1
      }],
      payment_intent_data: {
        metadata: {
          user_id: current_user.id,
          listing_id: @listing.id
        }
      }, success_url: "#{root_url}payments/success?userId=#{current_user.id}&listingId=#{@listing.id}",
      cancel_url: "#{root_url}listings"
    )

   @session_id = session.id
  end

  def new
    @listing = Listing.new
  end

  def create
  
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture)

    # @listing = Listing.new(listing_params)

    @listing = current_user.listings.create(listing_params)
    @listing.traits << Trait.find(params[:listing][:trait_id])
    @listing.save

    if @listing.save 
      redirect_to @listing
    else
      render :new
    end
    
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to @listing
    else
      render :edit
    end


    # listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture)

    # @listing.update(listing_params)
   
    # redirect_to listings_path
  end

  def destroy
    @listing.destroy
    redirect_to listings_path
  end

  def listing_params
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture)
  end
  

  private

  def set_listing
    id = params[:id]
    @listing = Listing.find(id)
  end

  def set_user_listing
    id = params[:id]
    @listing = current_user.listings.find_by_id(id)

    if @listing == nil
      redirect_to listings_path
    else
      if @listing.deposit == nil
        @listing.deposit = 0 #sometimes stripe doesn't allow a payment of zero? 
      end
    end

  end

  # def listing_params
  #   params.require(:listing).permit( :title, :description, :id)
  # end

end