#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
  
    
  before(:each) do
    @base_title = "Mynda"
  end

  subject { response }
  
  describe "Home page" do
     before { visit 'Home' }
       it { body.should include("Мянда затерянный край вдали городов !!!") } 
       it { should have_selector("title",:content => @base_title+"|Home") }
  end
  
  describe "Help page" do
    before { visit 'Help' }
    # response.should be_redirect  
    it { body.should include("Пример для саита!") } 
    it { should have_selector("title",:content => @base_title+"|Help") }
  end

  describe "About page" do
    before { visit 'About' }
    it { body.should include("Пример для саита!") }
    it { should have_selector("title",:content => @base_title+"|About") }
  end

  describe "Contact page" do
    before { visit 'Contact' }
    it { body.should include("Моя любимая жена!") } 
    it { should have_selector("title",:content => @base_title+"|Contact") }
  end
end
