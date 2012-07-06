require 'spec_helper'
describe PagesController do
  render_views
    
  before(:each) do
    @base = "Mynda"
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end

it "should have the right title" do
     get 'home'
<<<<<<< HEAD
     response.should have_selector("title",
                       :content =>
                           "Home")
=======
     response.should have_selector("title",:content => @base + "Home")
>>>>>>> static
   end
  end

  describe "GET 'contact'" do
    it "returns http success" do
      get 'contact'
      response.should be_success
    end

 it "should have the right title" do
      get 'contact'
<<<<<<< HEAD
      response.should have_selector("title",
                       :content =>
                                  "Contact")
=======
      response.should have_selector("title",:content => @base + "Contact")
>>>>>>> static
   end
  end

 describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

it "should have the right title" do
      get 'about'
<<<<<<< HEAD
      response.should have_selector("title",
                        :content =>
                          "About")
=======
      response.should have_selector("title",:content => @base + "About")
   end
  end

describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

it "should have the right title" do
      get 'help'
      response.should have_selector("title",:content => @base + "Help")
>>>>>>> static
   end
  end

end
