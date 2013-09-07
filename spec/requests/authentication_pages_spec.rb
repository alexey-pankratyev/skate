#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Authentication" do

  subject { response }

  describe "signin page" do
    before { visit signin_path }  

    it { should have_selector('h1',    content: 'Sign in') }
    it { should have_selector('title', content: 'Sign in') }

  end

  describe "signin" do
    
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', content: 'Sign in') }
      it { should have_selector('div.alert.alert-error', content: 'Invalid') }
      #it { should have_error_message 'Invalid' }

      describe "after visiting another page" do
        it { response.body.should have_link('Главная', :href => root_path) }
        before { click_link "Главная" }
        it { should_not have_selector('Invalid') }

      end

    end
  

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      
      before { valid_signin(user) }
      
      it { should have_selector('title', content: user.name) }
      it { response.body.should have_link('Профиль', href: user_path(user)) }
      it { response.body.should have_link('Выйти', href: signout_path) }
      
      describe "followed by signout" do
         before { click_link "Выйти", :method => :delete }
         it { response.body.should have_link('Войти', href: signin_path) }
      end
      
    end

  end

end