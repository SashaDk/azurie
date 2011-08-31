require 'spec_helper'

describe "answers/index.html.erb" do
  before(:each) do
    assign(:answers, [
      stub_model(Answer,
        :text => "MyText",
        :user_id => 1,
        :answer_id => 1
      ),
      stub_model(Answer,
        :text => "MyText",
        :user_id => 1,
        :answer_id => 1
      )
    ])
  end

  it "renders a list of answers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
