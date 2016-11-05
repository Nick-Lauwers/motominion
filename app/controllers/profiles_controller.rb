class ProfilesController < ApplicationController
  before_action :logged_in_user,  only: [:edit, :update]
  before_action :correct_user,    only: [:edit, :update]
  before_action :get_profile,     only: [:edit, :update]

  def show
    @profile =  Profile.find(params[:id])
    @vehicles = @profile.user.vehicles
  end
  
  def edit
  end
  
  def update
    if @profile.update_attributes(profile_params)
      flash[:success] = "Profile updated"
      redirect_to @profile
    else
      render 'edit'
    end
  end
  
  private
  
    def profile_params
      params.require(:profile).permit(:residence, 
                                      :school, 
                                      :work, 
                                      :description, 
                                      :avatar)
    end
    
    # Before filters
    
    # Confirms the correct user.
    def correct_user
      @profile = Profile.find(params[:id])
      redirect_to(root_path) unless (@profile == current_user.profile)
    end
    
    # Gets the current user's profile.
    def get_profile
      @profile = current_user.profile
    end
end

# http://www.bloomberg.com/news/photo-essays/2016-10-17/fabian-oefner-disintegrating-images-of-ferrari-mercedes-and-more