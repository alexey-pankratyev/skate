#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Users" do

 subject { response }

  describe "index" do

    let(:user) { FactoryGirl.create(:user) }

    before(:each) do
      sign_in user
      visit users_path
    end

    it { should have_selector('title', content: 'All users') }
    it { should have_selector('h1',    content: 'All users') }

    describe "pagination" do

      before(:all) { 30.times { FactoryGirl.create(:user) } }
      after(:all)  { User.delete_all }

      it { should have_selector('div.pagination') }

      it "should list each user" do
        User.paginate(page: 1).each do |user|
          response.body.should have_selector('li', content: user.name)
        end
      end
    end
  end



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

  describe "edit" do
    let(:user) { FactoryGirl.create(:user) }
    before { 
       sign_in user
       visit edit_user_path(user)
       }

    describe "page" do
      it { should have_selector('h1',    content: "Update your profile") }
      it { should have_selector('title', content: user.name) }
      it { response.body.should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
      before { click_button "Save changes" }

      it { response.body.should have_content('error') }
    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      before do
        fill_in "Имя",             with: new_name
        fill_in "Мыло",            with: new_email
        fill_in "Пароль",          with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', content: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { response.body.should have_link('Выйти', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end

  end
 
end
