class HouseholdsController < ApplicationController
  def index
    @user = current_user
    @households = Household.where(user: @user)
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

  def edit
    @user = current_user
    @household = Household.find(params[:id])
  end

  def update
    @user = current_user
    @household = Household.find(params[:id])
    if @household.update(household_params)
      flash[:notice] = "Household updated successfully"
      redirect_to households_path
    else
      flash[:errors] = @household.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    Household.find(params[:id]).destroy
    redirect_to households_path
  end

  def show
    @user = current_user
    @household = Household.find(params[:id])
    @bills = Bill.where(household: @household)
  end

  private

  def household_params
    params.require(:household).permit(:address, :city, :state, :zip, :occupants)
  end
end
