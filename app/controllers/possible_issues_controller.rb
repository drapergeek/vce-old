class PossibleIssuesController < ApplicationController
  skip_before_filter :check_authentication, :check_authorization , :only=>[:check]
  
  def index
    @possible_issues = PossibleIssue.all
  end
  
  def show
    @possible_issue = PossibleIssue.find(params[:id])
  end
  
  def new
    @possible_issue = PossibleIssue.new
  end
  
  def create
    @possible_issue = PossibleIssue.new(params[:possible_issue])
    if @possible_issue.save
      flash[:notice] = "Successfully created possible issue."
      redirect_to @possible_issue
    else
      render :action => 'new'
    end
  end
  
  def edit
    @possible_issue = PossibleIssue.find(params[:id])
  end
  
  def update
    @possible_issue = PossibleIssue.find(params[:id])
    if @possible_issue.update_attributes(params[:possible_issue])
      flash[:notice] = "Successfully updated possible issue."
      redirect_to @possible_issue
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @possible_issue = PossibleIssue.find(params[:id])
    @possible_issue.destroy
    flash[:notice] = "Successfully destroyed possible issue."
    redirect_to possible_issues_url
  end
  
  def check
    #this method will eventually be updated
    #it will read from the possibel issues table
    # and form there will process
    #for now we only have one issue to check for
    @campers = Camper.standard
    @not_cit = Array.new
    @campers.each do |c|
      if c.age > 12 && c.position == 0
        unless c.courses.include?(Course.find_by_name("CIT"))
          @not_cit<<c
        end
      end
    end
    if @not_cit.empty?
      flash[:notice] = "There we no issues found"
      redirect_to :controller=>"extras"
    else
      @not_cit.each do |c|
        #for each camper that is wrong we need to make an entry in the issues tablet
        #however we first need to see if there is an issue already listed in the tablet
        #with the same description
        description = "#{c.full_name} is eligble for the CIT class and is not registered for it."
        @match = Issue.find(:all, :conditions=>["unit_id like ? and description like ?", Thread.current["unit"].id, description])
        if @match.empty?
          logger.info "issue was not found so we created it"
          @issue = Issue.new(:name=>"CIT Issue", :description=>description, :ignore=>false)
          @issue.unit = Unit.find(Thread.current["unit"].id)
          @issue.save!
        else
          logger.info "The issue was already found so we didn't list it"
        end
        logger.info description
      end
      flash[:notice] = "we found cit issues"
      redirect_to :controller=>"extras"
    end
    
    
  end
end
