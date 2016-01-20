class BillsController < ApplicationController
  def new
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.new
    @kinds = ["Electric"] #Gas, Water next
  end

  def create
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.new(bill_params)
    @bill.household = @household
    @kinds = ["Electric"] #Gas, Water next
    if @bill.save
      @bill.update(date: "#{@bill.date.year}/#{@bill.date.month}/1")
      flash[:notice] = "Bill Created Successfully"
      redirect_to household_path(@household)
    else
      flash[:errors] = @bill.errors.full_messages.join(". ")
      render :new
    end
  end

  def edit
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.find(params[:id])
    @kinds = ["Electric"] #Gas, Water next
  end

  def update
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.find(params[:id])
    @kinds = ["Electric"] #Gas, Water next
    if @bill.update(bill_params)
      @bill.update(date: "#{@bill.date.year}/#{@bill.date.month}/1")
      flash[:notice] = "Bill updated successfully"
      redirect_to household_path(@household)
    else
      flash[:errors] = @bill.errors.full_messages.join(". ")
      render :edit
    end
  end

  def destroy
    @household = Household.find(params[:household_id])
    Bill.find(params[:id]).destroy
    redirect_to household_path(@household)
  end

  def show
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.find(params[:id])
    @data = Utilitydata.where(state: @household.state, kind: @bill.kind,
                              date: @bill.date).first
    if @data == nil
      @data = Utilitydata.new(state: @household.state, kind: @bill.kind,
                              date: @bill.date, amount: 10000000)
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:amount, :date, :kind)
  end
end
