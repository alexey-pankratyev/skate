#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
  #render_views
    
  before(:each) do
    @base_title = "Mynda"
  end

  
 subject { response }

  shared_examples_for "all static pages" do
     it { should have_selector('h4', content: heading) }
     it { should have_selector('title', content: full_title(page_title)) }
  end

  shared_examples_for "p" do
     it { should have_selector('p', content: heading) }
     it { should have_selector('title', content: full_title(page_title)) }
  end
 
  describe "Home page" do
     before { visit '/' }
       let(:heading)    { 'Мянда затерянный край вдали городов !!!' }
       let(:page_title) { '' }
       it_should_behave_like "all static pages"
       it { should_not have_selector 'title', text: '| Home' }
  end
  
  describe "Help page" do
    before { visit '/help' }
    let(:heading)    { 'Пример для саита!' } 
    let(:page_title) { 'Help' }
    it_should_behave_like "p"
  end

  describe "About page" do
    before { visit '/about' }
    let(:heading)    { 'Пример для саита!' }
    let(:page_title) { 'About' }
    it_should_behave_like "p"
  end

  describe "Contact page" do
    before { visit '/contact' }
     it { response.body.should include("Моя любимая жена!") } 
     it { should have_selector('title', content: full_title('Contact')) }
  end
  
  describe "Email page" do
    before { visit '/email' }
     it { response.body.should include("Пример для саита!") } 
     it { should have_selector('title', content: full_title('Email')) }
  end

  describe "Reviews page" do
    before { visit 'reviews' }
    it { response.body.should include("Пример для саита!") } 
    it { should have_selector('title', content: full_title('Reviews')) }
  end

  it "should have the right links on the layout" do
    visit '/'
    click_link "Цены"
    response.should have_selector 'title', content: full_title('About')
   end

 end
