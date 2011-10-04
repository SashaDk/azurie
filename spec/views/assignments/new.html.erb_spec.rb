require 'spec_helper'

describe "assignments/new.html.erb" do
  before(:each) do
    assign(:assignment, stub_model(Assignment,
      :user_id => 1,
      :question_id => 1
    ).as_new_record)
  end

  it "renders new assignment form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => assignments_path, :method => "post" do
      assert_select "input#assignment_user_id", :name => "assignment[user_id]"
      assert_select "input#assignment_question_id", :name => "assignment[question_id]"
    end
  end
end
