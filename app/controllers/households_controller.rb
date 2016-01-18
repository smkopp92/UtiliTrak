class HouseholdsController < ApplicationController
  def index
    @user = current_user
    @households = Household.where(user: @user)
  end
  def show

  end
  def new
    @user = current_user
    @household = Household.new
  end
  def create
    @user = current_user
    @household = Household.new(household_params)
    @household.user = current_user
    if @household.save
      flash[:notice] = "Household Created Successfully"
      redirect_to households_path
    else
      flash[:errors] = @household.errors.full_messages.join(". ")
      render :new
    end
  end
  private

  def household_params
    params.require(:household).permit(:address, :city, :state, :zip, :occupants)
  end
end
