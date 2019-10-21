class BreedsController < ListingsController 
  before_action :set_listing, only: [ :show, :edit, :update, :destroy ]

  def index
    @breeds = Breed.all
  end

  def new
    @breed = Breed.new
  end

  def show
  end

  def edit
  end

  def create
    breed_params = params.require(:breed).permit(:name)

    @breed = Breed.new(breed_params)
    if @breed.save 
      redirect_to @breed
    else
      render :new
    end
    
  end

  def update
    breed_params = params.require(:breed).permit(:name)

    @breed.update(breed_params)

    redirect_to @breed
  end

  def destroy
    @breed.destroy
   
    redirect_to breeds_path
  end



  private

  def set_listing
    id = params[:id]
    @breed = Breed.find(id)
  end

end