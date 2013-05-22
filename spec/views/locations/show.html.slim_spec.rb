require 'spec_helper'

describe "locations/show" do
  before(:each) do
    @location = assign(:location, stub_model(Location,
      :address => "Address",
      :address1 => "Address1",
      :city => "City",
      :state => "State",
      :zip => "",
      :max => "",
      :country => "Country"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Address/)
    rendered.should match(/Address1/)
    rendered.should match(/City/)
    rendered.should match(/State/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Country/)
  end
end
