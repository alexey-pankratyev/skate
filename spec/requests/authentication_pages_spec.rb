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

      describe "after visiting another page" do
        before { click_link "Главная" }
        it { should_not have_selector('div.alert.alert-error') }
      end

    end
  

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        visit signin_path
        fill_in "Email",    with: user.email.upcase
        fill_in "Password", with: user.password
        click_button "Sign in"
        
      end

      it { should have_selector('title', text: user.name) }
      it { should have_link('Профиль', href: user_path(user)) }
      it { should have_link('Выйти', href: signout_path) }

      describe "followed by signout" do
        before { click_link "Выйти" }
        it { should have_link('Войти') }
      end
      
    end

  end

end