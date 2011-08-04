require 'spec_helper'

describe "questions/edit.html.haml" do
  before(:each) do
    @question = assign(:question, stub_model(Question,
      :title => "MyText",
      :answer => "MyText",
      :category => "MyText",
      :question_author_id => 1,
      :answer_author_id => 1
    ))
  end

  it "renders the edit question form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => questions_path(@question), :method => "post" do
      assert_select "textarea#question_title", :name => "question[title]"
      assert_select "textarea#question_answer", :name => "question[answer]"
      assert_select "textarea#question_category", :name => "question[category]"
      assert_select "input#question_question_author_id", :name => "question[question_author_id]"
      assert_select "input#question_answer_author_id", :name => "question[answer_author_id]"
    end
  end
end
