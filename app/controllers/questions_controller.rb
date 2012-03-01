class QuestionsController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index, :search]
  load_and_authorize_resource

  # GET /records/search
  def search
    @page = params[:page].to_i + 1 if params[:page]
    @questions = Question.search params[:q], :match_mode => :boolean, :page => @page, :per_page => params[:pagelimit]
    @questions_count = @questions.total_entries
    respond_to do |format|
      format.html # search.html.erb
    end
  end

  # GET /questions
  # GET /questions.xml
  def index
    @questions = params[:category].blank? ? Question.top : Question.category(params[:category])
    @questions = @questions.includes(:answers, :tags).paginate(:page => params[:page])
    @questions = @questions.order(:created_at.desc) if params[:order] == 'date'
    @questions = @questions.order(:answers_count.desc) if params[:order] == 'popular'
    @questions_count = @questions.count
    @answers_count = Answer.where(:question_id => @questions).count
    @questions = @questions.paginate(:page => params[:page])
    respond_to do |format|
      format.html # index.html.erb
      format.js # index.js.erb
      format.xml  { render :xml => @questions }
    end
  end
  
  # GET /questions/pending
  # GET /questions/pending.xml
  def pending
    @questions = Question.pending
    respond_to do |format|
      format.html # pending.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/unanswered
  # GET /questions/unanswered.xml
  def unanswered
    @questions = Question.unanswered
    respond_to do |format|
      format.html # unanswered.html.erb
      format.xml  { render :xml => @questions }
    end
  end

  # GET /questions/1
  # GET /questions/1.xml
  def show
    @question = Question.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/new
  # GET /questions/new.xml
  def new
    @question = Question.new
    @question.answers.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @question }
    end
  end

  # GET /questions/1/edit
  def edit
    @question = Question.find(params[:id])
  end

  # GET /questions/1/verify
  def verify
    @question = Question.find(params[:id])
    @question.verify
    redirect_to(pending_questions_path, :notice => 'Question was successfully verified.')
  end

  # GET /questions/1/unverify
  def unverify
    @question = Question.find(params[:id])
    @question.unverify
    redirect_to(pending_questions_path, :notice => 'Question was successfully unverified.')
  end

  # POST /questions
  # POST /questions.xml
  def create
    @question = Question.new(params[:question])
    @question.user = current_user 
     @question.answers.first.user = current_user if @question.answers.any?
    
    respond_to do |format|
      if @question.save
        format.html { redirect_to(@question, :notice => 'Question was successfully created.') }
        format.xml  { render :xml => @question, :status => :created, :location => @question }
      else
        @question.answers.build unless @question.answers.any?
        format.html { render :action => "new" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1
  # PUT /questions/1.xml
  def update
    @question = Question.unscoped.find(params[:id])

    respond_to do |format|
      if @question.update_attributes(params[:question])
        format.html { redirect_to(@question, :notice => 'Question was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @question.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.xml
  def destroy
    @question = Question.unscoped.find(params[:id])
    @question.destroy

    respond_to do |format|
      format.html { redirect_to(questions_url) }
      format.xml  { head :ok }
    end
  end
end
