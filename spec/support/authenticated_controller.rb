shared_examples "an authenticated controller" do |a, t|
  act = a || 'index'
  template = t || 'index'

  let(:act) { a || :index }
  let(:template) { t || :index }

  def get_action
    get act
  end

  describe "with authenticated user" do
    login_user

    it "should have a current_user" do
      subject.current_user.should_not be_nil
    end

    it "does render the #{template} template" do
      get_action
      response.should render_template(template)
    end
  end

  describe "without authenticated user" do

    it "should not have a current_user" do
      subject.current_user.should be_nil
    end

    it "does not render the template" do
      get_action
      response.should_not render_template(template)
    end
  end
end