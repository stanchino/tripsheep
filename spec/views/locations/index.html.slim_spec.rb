require 'spec_helper'

describe "locations/index" do
  before(:each) do
    assign(:locations, [
      stub_model(Location,
        :address => "Address",
        :address1 => "Address1",
        :city => "City",
        :state => "State",
        :zip => "",
        :max => "",
        :country => "Country"
      ),
      stub_model(Location,
        :address => "Address",
        :address1 => "Address1",
        :city => "City",
        :state => "State",
        :zip => "",
        :max => "",
        :country => "Country"
      )
    ])
  end

  it "renders a list of locations" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Address1".to_s, :count => 2
    assert_select "tr>td", :text => "City".to_s, :count => 2
    assert_select "tr>td", :text => "State".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
    assert_select "tr>td", :text => "Country".to_s, :count => 2
  end
end
