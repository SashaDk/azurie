class BriefingsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :social_handler]
  load_and_authorize_resource
  uses_tiny_mce :only => [:new, :create, :edit, :update]

  # GET /briefings
  # GET /briefings.xml
  def index
    @briefings = params[:category].blank? ? Briefing.all : Briefing.category(params[:category])
    @briefings = @briefings.paginate(:page => params[:page])
    @briefings_count = Briefing.count
    @comments_count = Briefing.select('sum(comments_count) as comments_sum').first.comments_sum || 0

    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.rss # index.rss.builder
    end
  end

  # GET /briefings/1
  # GET /briefings/1.xml
  def show
    return redirect_to "http://www.azurie.com/briefings/11?locale=en" if params[:id] == 11
    @briefing = Briefing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @briefing }
    end
  end

  # GET /briefings/1/social_handler
  def social_handler
    @briefing = Briefing.find(params[:id])
    if params[:type] == "like"
      @briefing.likes_count += 1 if params[:act] == "inc"
      @briefing.likes_count -= 1 if params[:act] == "dec"
    end
    if params[:type] == "comment"
      @briefing.comments_count += 1 if params[:act] == "inc"
      @briefing.comments_count -= 1 if params[:act] == "dec"
    end
    @briefing.save!

    respond_to do |format|
      format.json { render :json => :ok }
    end
  end 

  # GET /briefings/new
  # GET /briefings/new.xml
  def new
    @briefing = Briefing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @briefing }
    end
  end

  # GET /briefings/1/edit
  def edit
    @briefing = Briefing.find(params[:id])
  end

  # POST /briefings
  # POST /briefings.xml
  def create
    @briefing = Briefing.new(params[:briefing])
    @briefing.user = current_user

    respond_to do |format|
      if @briefing.save
        format.html { redirect_to(@briefing, :notice => 'Briefing was successfully created.') }
        format.xml  { render :xml => @briefing, :status => :created, :location => @briefing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @briefing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /briefings/1
  # PUT /briefings/1.xml
  def update
    @briefing = Briefing.find(params[:id])

    respond_to do |format|
      if @briefing.update_attributes(params[:briefing])
        format.html { redirect_to(@briefing, :notice => 'Briefing was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @briefing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /briefings/1
  # DELETE /briefings/1.xml
  def destroy
    @briefing = Briefing.find(params[:id])
    @briefing.destroy

    respond_to do |format|
      format.html { redirect_to(briefings_url) }
      format.xml  { head :ok }
    end
  end
end
