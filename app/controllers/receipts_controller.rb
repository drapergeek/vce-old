class ReceiptsController < ApplicationController

  if Rails.env == "production"
    before_filter :login_required
  else
    before_filter :set_dev_user
  end
  helper_method :sort_column, :sort_direction
  layout "application" ,  :except => {:export_excel, :create_excel}

    
 #This is a method for showing a report of totals...
 #mainly its a sum screen
 def totals
   @receipts = Receipt.find_standard_receipts
   @receipts_dates = @receipts.group_by{|r| r.date.beginning_of_day}
 end
  
  #This method returns just a list of sortable columns
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
  end

#  def list_by_date
#    date = params[:date]
##    sort_init 'date'
#    sort_update
#    @receipts = Receipt.paginate_standard_receipts :conditions => [ "date LIKE ?", "%#{date}%"],  :page=>params[:page], :per_page=>20
#    render :action=>'index'
#  end
  
  
#  def show_by_date
#    @date = params[:date]
#    @receipts = Receipt.find_standard_receipts( :conditions => [ "date LIKE ?", "%#{params[:date]}%"])
#  end

  def show
    @receipt = Receipt.find(params[:id])
  end

  def new
    @receipt = Receipt.new
    @states = State.find(:all)
    @camp_price = current_user.unit.camp_price || 210.00
  end

  def create
    @camp_price = current_user.unit.camp_price
    @receipt = Receipt.new(params[:receipt])
     unless current_user.unit == 'State Wide'
        @receipt.unit = current_user.unit
      end
    @receipt.user = current_user
    if @receipt.save
      #ReceiptMailer.deliver_receipt_confirmation(@receipt) unless @receipt.email.blank?
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
    @camp_price = current_user.unit.camp_price
  end

  def update
    prev = 0
    @receipt = Receipt.find(params[:id])
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
