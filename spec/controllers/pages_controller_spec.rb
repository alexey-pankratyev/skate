require 'spec_helper'
describe PagesController do
  render_views
    
  before(:each) do
    @base_title = "Mynda"
  end

  describe "GET 'home'" do
    it "returns http success" do
      get 'home'
      response.should be_success
    end

it "should have the right title" do
     get 'home'
<<<<<<< HEAD
     response.should have_selector("title",:content => @base + "Home")

=======
     response.should have_selector("title",:content => @base_title+"|Home")
>>>>>>> nachalocss
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
      response.should have_selector("title",:content => @base + "Contact")

=======
      response.should have_selector("title",:content => @base_title+"|Contact")
>>>>>>> nachalocss
   end
  end

 describe "GET 'about'" do
    it "should be successful" do
      get 'about'
      response.should be_success
    end

it "should have the right title" do
      get 'about'
      response.should have_selector("title",:content => @base_title+"|About")
   end
  end

describe "GET 'help'" do
    it "should be successful" do
      get 'help'
      response.should be_success
    end

it "should have the right title" do
      get 'help'
      response.should have_selector("title",:content => @base_title+"|Help")
   end
  end

end
