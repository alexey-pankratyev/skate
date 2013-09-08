#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Users" do

 subject { response }

  describe "signup page" do
    before { visit signup_path } 
    it { should have_content_h1_title('Sign up') }
    it { should have_selector('title', content: full_title('Sign up')) }
  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    before { visit user_path(user) }
    it { should have_content_h1_title(user.name) }
  end


  describe "signup" do

    before { visit signup_path }

    let(:submit) { "Sign up" }
  
    describe "with invalid information" do

      describe "after submission" do
        
        before { click_button submit }
        it { should have_content_h1_title('Sign up') }
        it { should have_selector("div#error_explanation") }
        
      end
 
      it "should not create a user" do
        expect { click_button submit }.not_to change(User, :count)
      end

    end

    
    describe "with valid information" do

      before do
        fill_in "Имя",          with: "Example User"
        fill_in "Мыло",         with: "user@example.com"
        fill_in "Пароль",       with: "foobar"
        fill_in "Confirmation", with: "foobar"
      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
      end

      describe "after saving the user" do
        before { click_button submit }
         let(:user) { User.find_by_email('user@example.com') }
         it { response.body.should include(user.name) } 
         it { should have_selector('title', content: user.name) }
         it { should have_selector('div.alert.alert-success', content: 'Welcome') }
         it { response.body.should have_link('Выйти') }

      end

    end
  end

end
