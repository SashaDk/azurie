require 'spec_helper'

describe "briefings/index.html.erb" do
  before(:each) do
    assign(:briefings, [
      stub_model(Briefing,
        :title => "MyText",
        :description => "MyText",
        :category => "MyText",
        :source => "MyText",
        :is_quote => false,
        :user_id => 1
      ),
      stub_model(Briefing,
        :title => "MyText",
        :description => "MyText",
        :category => "MyText",
        :source => "MyText",
        :is_quote => false,
        :user_id => 1
      )
    ])
  end

  it "renders a list of briefings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => false.to_s, :count => 2
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
