class AssignmentsController < ApplicationController
  before_filter :find_question
  
  # GET /assignment
  # GET /assignment.xml
  def index
    @assignments = @question.assignments.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignment/1
  # GET /assignment/1.xml
  def show
    @assignment = @question.assignments.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignment/new
  # GET /assignment/new.xml
  def new
    @assignment = @question.assignments.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @assignment }
    end
  end

  # GET /assignment/1/edit
  def edit
    @assignment = @question.assignments.find(params[:id])
  end

  # POST /assignment
  # POST /assignment.xml
  def create
    @assignment = @question.assignments.new(params[:assignment])

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to([@question, @assignment], :notice => 'Assignent was successfully created.') }
        format.xml  { render :xml => @assignment, :status => :created, :location => @assignment }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /assignment/1
  # PUT /assignment/1.xml
  def update
    @assignment = @question.assignments.find(params[:id])

    respond_to do |format|
      if @assignment.update_attributes(params[:assignment])
        format.html { redirect_to([@question, @assignment], :notice => 'Assignent was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assignment.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /assignment/1
  # DELETE /assignment/1.xml
  def destroy
    @assignment = @question.assignments.find(params[:id])
    @assignment.destroy

    respond_to do |format|
      format.html { redirect_to(question_assignment_url(@question)) }
      format.xml  { head :ok }
    end
  end
  
protected
  def find_question
    @question = Question.find(params[:question_id])
  end
end
