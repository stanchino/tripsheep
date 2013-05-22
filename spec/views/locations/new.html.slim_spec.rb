require 'spec_helper'

describe "locations/new" do
  before(:each) do
    assign(:location, stub_model(Location,
      :address => "MyString",
      :address1 => "MyString",
      :city => "MyString",
      :state => "MyString",
      :zip => "",
      :max => "",
      :country => "MyString"
    ).as_new_record)
  end

  it "renders new location form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", locations_path, "post" do
      assert_select "input#location_address[name=?]", "location[address]"
      assert_select "input#location_address1[name=?]", "location[address1]"
      assert_select "input#location_city[name=?]", "location[city]"
      assert_select "input#location_state[name=?]", "location[state]"
      assert_select "input#location_zip[name=?]", "location[zip]"
      assert_select "input#location_max[name=?]", "location[max]"
      assert_select "input#location_country[name=?]", "location[country]"
    end
  end
end
