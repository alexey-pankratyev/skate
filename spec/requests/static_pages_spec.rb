#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
  #render_views
    
  before(:each) do
    @base_title = "Mynda"
  end

  
  subject { response }

  describe "Home page" do
     before { visit 'Home' }
       it { response.body.should include("Мянда затерянный край вдали городов !!!") } 
       it { should have_selector('title', content: full_title('')) }
       it { should_not have_selector 'title', text: '| Home' }
  end
  
  describe "Help page" do
    before { visit 'Help' }
    # response.should be_redirect  
    it { response.body.should include("Пример для саита!") } 
    it { should have_selector('title',content:  full_title('Help')) }
  end

  describe "About page" do
    before { visit 'About' }
    it { response.body.should include("Пример для саита!") }
    it { should have_selector('title', content: full_title('About')) }
  end

  describe "Contact page" do
    before { visit 'Contact' }
     it { response.body.should include("Моя любимая жена!") } 
     it { should have_selector('title', content: full_title("Contact")) }
  end
  
  describe "Email page" do
    before { visit 'Email' }
     it { response.body.should include("Пример для саита!") } 
     it { should have_selector('title', content: full_title("Email")) }
  end

  describe "Reviews page" do
    before { visit 'Reviews' }
     it { response.body.should include("Пример для саита!") } 
     it { should have_selector('title', content: full_title("Reviews")) }
  end

  describe "Contact page" do
    before { visit 'Contact' }
     it { response.body.should include("Пример для саита!") } 
     it { should have_selector('title', content: full_title("Contact")) }
  end

end
