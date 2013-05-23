require 'spec_helper'

describe "Static pages" do

  describe "Home page" do
  # subject { page }
  before { visit root_path }
    it { should have_selector('title', text: full_title('')) }
  end

  it "should have a Help page at '/Help'" do
    get '/Help'
    response.should have_selector('title', :content => "Help")
  end

  it "should have a signup page at '/About'" do
    get '/About'
    response.should have_selector('title', :content => "About")
  end
 
  it "should have a signup page at 'Contact'" do
    get 'Contact'
    response.should have_selector('title', :content => "Contact")
  end

  it "should have a Help page at '/Email'" do
    get '/Email'
    response.should have_selector('title', :content => "Email")
  end

  it "should have a Help page at '/Reviews'" do
    get '/Reviews'
    response.should have_selector('title', :content => "Reviews")
  end

  it "should have a signup page at '/signup'" do
    get '/signup'
    response.should have_selector('title', :content => "Sign up")
  end

end

  describe "when not signed in" do
    it "should have a signin link" do
   #  visit root_path
   #  response.should have_selector("a", :href => signin_path,
   #                                    :content => "login")
    end
  end

  describe "when signed in" do

    before(:each) do
     # @user = Factory(:user)
      integration_sign_in(Factory(:user))
      #visit signin_path
      #fill_in :email,    :with => @user.email
      #fill_in :password, :with => @user.password
      #click_button
    end

    it "should have a signout link" do
    #  visit root_path
    #  response.should have_selector("a", :href => signout_path,
      #                                   :content => "Sign out")
    end

    it "should have a profile link" do
     #visit root_path
     # response.should have_selector("a", :href => user_path(@user),
     #                                    :content => "Profile")
      end

end

