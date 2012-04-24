class ReceiptsController < ApplicationController
  helper_method :sort_column, :sort_direction

  def totals
    @receipts = Receipt.find_standard_receipts
    @receipts_dates = @receipts.group_by{|r| r.date.beginning_of_day}
    authorize! :totals, Receipt
  end

  def index
    if params[:search]
      @receipts = Receipt.search(params[:search]).paginate(:per_page=>25, :page=>params[:page])
      if @receipts.count > 3
        flash[:notice] = "Your search for "#{params[:search]}" did not return any results"
        params[:search] = nil
      end
    else
      @receipts = Receipt.order(sort_column + " "+ sort_direction).paginate(:per_page=>25, :page=>params[:page])
    end
    respond_to do |format|
      format.html
      format.csv { render :csv => Receipt.all}
    end
  end

  def show
    @receipt = Receipt.find(params[:id])
    authorize! :show, @receipt
  end

  def new
    @receipt = Receipt.new
    @states = State.find(:all)
    @camp_price = current_user.unit.camp_price
    @collage_price = current_user.unit.collage_price
    authorize! :new, @receipt
  end

  def create
    @camp_price = current_user.unit.camp_price
    @receipt = Receipt.new(params[:receipt])
    unless current_user.unit == 'State Wide'
      @receipt.unit = current_user.unit
    end
    @receipt.user = current_user
    @receipt.date = Time.now
    authorize! :create, @receipt
    if @receipt.save
      flash[:notice] = 'Receipt was successfully created.'
      redirect_to :action => 'show', :id=>@receipt
    else
      @states = State.find(:all)
      render :action => 'new'
    end
  end

  def edit
    @receipt = Receipt.find(params[:id])
    @states = State.find(:all)
    @camp_price = 215.00 
    authorize! :edit, @receipt
  end

  def update
    prev = 0
    @receipt = Receipt.find(params[:id])
    authorize! :update, @receipt
    @states = State.find(:all)
    @camp_price = current_user.unit.camp_price
    unless @receipt.refund.blank? || @receipt.refund.nil? || @receipt.refund==0
      prev = 1
    end
    if @receipt.update_attributes(params[:receipt])
      if @receipt.refund==true && prev==0
        @receipt.refund_date = Time.now
        @receipt.save
      end
      flash[:notice] = 'Receipt was successfully updated.'
      redirect_to :action => 'show', :id => @receipt
    else
      flash[:notice] = 'There was an error updating the receipt'
      render :action => 'edit'
    end
  end

  def destroy
    receipt =  Receipt.find(params[:id])
    authorize! :destroy, receipt
    if receipt.unit =  Thread.current["unit"]
      receipt.destroy
      flash[:notice] = "Your receipt has been successfully deleted."
      redirect_to :action => 'index'
    else
      flash[:notice]= "You cannot delete a receipt that is not in your unit"
      rediect_to :action =>'index'
    end
  end


  #  def validate


  private


  def sort_column
    Receipt.column_names.include?(params[:sort]) ? params[:sort] : "id"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end




end
