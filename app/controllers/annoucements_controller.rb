class AnnoucementsController < ApplicationController
  layout 'application'
  # GET /annoucements
  # GET /annoucements.xml
  def index
    @annoucements = Annoucement.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @annoucements }
    end
  end

  # GET /annoucements/1
  # GET /annoucements/1.xml
  def show
    @annoucement = Annoucement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @annoucement }
    end
  end

  # GET /annoucements/new
  # GET /annoucements/new.xml
  def new
    @annoucement = Annoucement.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @annoucement }
    end
  end

  # GET /annoucements/1/edit
  def edit
    @annoucement = Annoucement.find(params[:id])
  end

  # POST /annoucements
  # POST /annoucements.xml
  def create
    @annoucement = Annoucement.new(params[:annoucement])

    respond_to do |format|
      if @annoucement.save
        flash[:notice] = 'Annoucement was successfully created.'
        format.html { redirect_to(@annoucement) }
        format.xml  { render :xml => @annoucement, :status => :created, :location => @annoucement }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @annoucement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /annoucements/1
  # PUT /annoucements/1.xml
  def update
    @annoucement = Annoucement.find(params[:id])

    respond_to do |format|
      if @annoucement.update_attributes(params[:annoucement])
        flash[:notice] = 'Annoucement was successfully updated.'
        format.html { redirect_to(@annoucement) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @annoucement.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /annoucements/1
  # DELETE /annoucements/1.xml
  def destroy
    @annoucement = Annoucement.find(params[:id])
    @annoucement.destroy

    respond_to do |format|
      format.html { redirect_to(annoucements_url) }
      format.xml  { head :ok }
    end
  end
  

end
