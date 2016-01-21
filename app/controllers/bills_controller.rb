class BillsController < ApplicationController
  def new
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.new
    @kinds = ["Electric", "Gas", "Water"]
  end

  def create
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.new(bill_params)
    @bill.household = @household
    @kinds = ["Electric", "Gas", "Water"]
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
    @kinds = ["Electric", "Gas", "Water"]
  end

  def update
    @user = current_user
    @household = Household.find(params[:household_id])
    @bill = Bill.find(params[:id])
    @kinds = ["Electric", "Gas", "Water"]
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
    @bills = Bill.where(date: @bill.date, household_id: @bill.household_id)
    if @bills.length == 1
      flash[:notice] = "Please add more bills for this month to see breakdown"
    end
    d = []
    @bills.each do |bill|
      d << [bill.kind, bill.amount]
    end
    @data = Utilitydata.where(state: @household.state, kind: @bill.kind,
                              date: @bill.date).first
    if @data == nil
      @data = Utilitydata.new(state: @household.state, kind: @bill.kind,
                              date: @bill.date, amount: 10000000)
    end
    text = "Breakdown for #{@bill.date.month}/#{@bill.date.year}"
    @chart3 = LazyHighCharts::HighChart.new('pie') do |f|
      f.chart({ defaultSeriesType: "pie", margin: [50, 200, 60, 170] } )
      series = {
        type: 'pie',
        name: 'Amount($)',
        data: d
        }
      f.series(series)
      f.options[:title][:text] = text
      f.legend(layout: 'vertical', style: {
        left: 'auto', bottom: 'auto', right: '50px', top: '100px'
        })
      f.plot_options(pie: {
        allowPointSelect: true,
        cursor: "pointer",
        dataLabels: {
          enabled: true,
          color: "black",
          style:{
            font: "13px Trebuchet MS, Verdana, sans-serif"
            }
          }
        })
    end
  end

  private

  def bill_params
    params.require(:bill).permit(:amount, :date, :kind)
  end
end
