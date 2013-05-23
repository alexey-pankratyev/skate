#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
#include Rails.application.routes.url_helpers
  describe "Home page" do

    it "should have the content 'app'" do
      visit 'Home'
    # response.should be_redirect  
      response.body.should include("Мянда затерянный край вдали городов !!!") 
    end
  end
  
  describe "Help page" do

    it "should have the content 'help'" do
      visit 'Help'
    # response.should be_redirect  
      response.body.should include("Пример для саита!") 
    end
  end

end
