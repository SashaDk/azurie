class AnswersController < ApplicationController
  before_filter :authenticate_user!, :except => [:show, :index]
  before_filter :find_question

  # GET /questions/1/answers
  # GET /questions/1/answers.xml
  def index
    @answers = @question.answers.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @answers }
    end
  end

  # GET /questions/1/answers/1
  # GET /questions/1/answers/1.xml
  def show
    @answer = @question.answers.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /questions/1/answers/new
  # GET /questions/1/answers/new.xml
  def new
    @answer = @question.answers.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @answer }
    end
  end

  # GET /questions/1/answers/1/edit
  def edit
    @answer = @question.answers.find(params[:id])
  end

  # POST /questions/1/answers
  # POST /questions/1/answers.xml
  def create
    @answer = @question.answers.build(params[:answer])
    @answer.user = current_user

    respond_to do |format|
      if @answer.save
        format.html { redirect_to([@question,@answer], :notice => 'Answer was successfully created.') }
        format.xml  { render :xml => @answer, :status => :created, :location => @answer }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /questions/1/answers/1
  # PUT /questions/1/answers/1.xml
  def update
    @answer = @question.answers.find(params[:id])

    respond_to do |format|
      if @answer.update_attributes(params[:answer])
        format.html { redirect_to([@question,@answer], :notice => 'Answer was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @answer.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1/answers/1
  # DELETE /questions/1/answers/1.xml
  def destroy
    @answer = @question.answers.find(params[:id])
    @answer.destroy

    respond_to do |format|
      format.html { redirect_to(question_answers_url(@question)) }
      format.xml  { head :ok }
    end
  end

  protected

  def find_question
    @question = Question.find params[:question_id]
  end
end
