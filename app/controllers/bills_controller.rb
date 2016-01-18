class BillsController < ApplicationController
  def new
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.new
  end

  def create
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.new(bill_params)
    @bill.household = @household
    if @bill.save
      flash[:notice] = "Bill Created Successfully"
      redirect_to household_path(@household)
    else
      flash[:errors] = @bill.errors.full_messages.join(". ")
      render :new
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:amount, :date, :kind)
  end
end
