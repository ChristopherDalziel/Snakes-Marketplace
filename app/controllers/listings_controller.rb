class ListingsController < ApplicationController
  before_action :set_listing, only: [ :show, :edit, :update, :destroy ]

  def index
      @listings = Listing.all
  end

  def show
    
  end

  def new
    @listing = Listing.new
  end

  def create
  
    listing_params = params.require(:listing).permit(:title, :description, :breed_id, :sex, :price, :deposit, :city, :state, :date_of_birth, :diet, :picture)

    @listing = Listing.new(listing_params)
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

  # def listing_params
  #   params.require(:listing).permit( :title, :description, :id)
  # end

end