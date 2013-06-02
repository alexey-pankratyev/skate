#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
  
    
  before(:each) do
    @base_title = "Mynda"
  end
  
  describe "Home page" do

    it "should have the content 'mynda'" do
      visit 'Home'
      response.body.should include("Мянда затерянный край вдали городов !!!") 
    end

    it "should have the base title" do
      visit 'Home'
      response.should have_selector("title",:content => @base_title+"|Home")
    end
   
  end
  
  describe "Help page" do

    it "should have the content 'Primer'" do
      visit 'Help'
    # response.should be_redirect  
      response.body.should include("Пример для саита!") 
    end
  end

  describe "About page" do

    it "should have the content 'Primer'" do
      visit 'About'
    # response.should be_redirect  
      response.body.should include("Пример для саита!") 
    end
  end

  describe "Contact page" do

    it "should have the content 'Zjena'" do
      visit 'Contact'
    # response.should be_redirect  
      response.body.should include("Моя любимая жена!") 
    end
  end
end
