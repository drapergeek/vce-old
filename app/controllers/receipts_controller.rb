class ReceiptsController < ApplicationController
  helper :sort
  
  include SortHelper
  
  before_filter :login_required 
  before_filter :authorize, :only=>{:edit, :destroy}
  layout "application" ,  :except => {:export_excel, :create_excel}

  # GETs should be safe (see http://www.w3.org/2001/tag/doc/whenToUseGet.html)
  verify :method => :post, :only => [ :destroy, :create ],
         :redirect_to => { :action => :index }
  CAMP_PRICE = 200.00
         
 #This is a method for showing a report of totals...
 #mainly its a sum screen
 def totals
   @receipts = Receipt.find_standard_receipts
   @receipts_dates = @receipts.group_by{|r| r.date.beginning_of_day}
 end
  
  #This method returns just a list of sortable columns
  def index
      sort_init 'date' 
      sort_update
      @receipts = Receipt.paginate_standard_receipts :page=>params[:page], :per_page=>20, :order=>sort_clause
  end
  
  #This is the search paramater and passes to the search.rhtml file
  def search
    @receipts = Receipt.search(params[:search])
    logger.info("Here it is: " + @receipts.to_s)
    if @receipts.blank? || @receipts.empty?
      flash[:notice] = "There were no receipts matching the search term \"#{params[:search]}\""
      redirect_to :action=>'index'
    end
      @header_text = "Search Results for \"#{params[:search]}\""
      @link_text = 'Back to all receipts'
      @link_action = 'index'
  end
    

  
  def list_by_date
    date = params[:date]
    @receipts = Receipt.find_standard_receipts( :conditions => [ "date LIKE ?", "%#{date}%"])
    render :action=>'search'
  end
  
  def show_by_date
    @date = params[:date]
    @receipts = Receipt.find_standard_receipts( :conditions => [ "date LIKE ?", "%#{params[:date]}%"])
  end


  #Do you really need documentation for a show method?
  def show
    @receipt = Receipt.find(params[:id])
  end

  def new
    @receipt = Receipt.new
    @states = State.find(:all)
    @camp_price = CAMP_PRICE
  end

  def create
     @camp_price = CAMP_PRICE
    @receipt = Receipt.new(params[:receipt])
     unless current_user.unit == 'State Wide'
        @receipt.unit = current_user.unit
      end
    @receipt.user = current_user
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
    @camp_price = CAMP_PRICE
  end

  def update
    logger.error "got into update"
    prev = 0
    @receipt = Receipt.find(params[:id])
    @states = State.find(:all)
    @camp_price = CAMP_PRICE
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
      flash[:notice] = "Your receipt has been successfull deleted."
      redirect_to :action => 'index'
  else
     flash[:notice]= "You cannot delete a receipt that is not in your unit"
     rediect_to :action =>'index'
  end
   
  end
  


  
end
