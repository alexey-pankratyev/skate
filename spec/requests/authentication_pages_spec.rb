#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }  
    it { should have_content_h1_title('Sign in') }
  end

  describe "signin" do
    
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_selector('title', content: 'Sign in') }
      it { should have_selector('div.alert.alert-error', content: 'Invalid') }

      describe "after visiting another page" do
        it { should have_link('Главная', :href => root_path) }
        before { click_link "Главная" }
        it { should_not have_selector('div.alert.alert-error') }
      end

    end
  

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      
      before do        
        sign_in user
      end 
      
      it { should have_selector('title', content: user.name) }
      it { should have_link('Настройка', href: edit_user_path(user)) }
      it { should have_link('Профиль', href: user_path(user)) }
      it { should have_link('Выйти', href: signout_path) }
      it { should have_link('Пользователи', href: users_path) }
      
      describe "followed by signout" do

       before do 
        click_link "Выйти"
       end
         it { should have_link('Войти', href: signin_path) }
         it { should_not have_link('Настройка', href: edit_user_path(user)) }
         it { should_not have_link('Профиль', href: user_path(user)) }
         it { should_not have_link('Выйти', href: signout_path) }

      end
      
    end

  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "when attempting to visit a protected page" do
        before do
          visit edit_user_path(user)
          fill_in "Email",    with: user.email
          fill_in "Password", with: user.password
          click_button "Sign in"
        end

        describe "after signing in" do

          it "should render the desired protected page" do
             should have_selector('h1', content: "Update your profile") 
          end

          describe "when signing in again" do
            before do
              delete signout_path
              visit signin_path
              fill_in "Email",    with: user.email
              fill_in "Password", with: user.password
              click_button "Sign in"
            end

            it "should render the default (profile) page" do
              should have_selector('title', content: user.name)
            end
          end
        
        end

      end

      describe "in the Microposts controller" do

         describe "submitting to the create action" do
          before { post microposts_path }
          specify { should redirect_to(signin_path) }
         end

         describe "submitting to the destroy action" do
          before { delete micropost_path(FactoryGirl.create(:micropost)) }
          specify { should redirect_to(signin_path) }
         end
      end
      
      describe "in the Relationships controller" do
        describe "submitting to the create action" do
          before { post relationships_path }
          specify { should redirect_to(signin_path) }
        end

        describe "submitting to the destroy action" do
          before { delete relationship_path(1) }
          specify { should redirect_to(signin_path) }
        end
      end

      describe "in the Users controller" do

        describe "visiting the following page" do
          before { visit following_user_path(user) }
          it { should have_selector('title', content: 'Sign in') }
        end

        describe "visiting the followers page" do
          before { visit followers_user_path(user) }
          it { should have_selector('title', content: 'Sign in') }
        end

        describe "visiting the edit page" do
          before { visit edit_user_path(user) }
          it { should have_selector('title', content: 'Sign in') }
        end

        describe "submitting to the update action" do
          before { put user_path(user) }
          specify { should redirect_to(signin_path) }
        end

        describe "visiting the user index" do
          before { visit users_path }
          it { should have_selector('title', content: 'Sign in') }
        end
      end



    end

    describe "as wrong user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before { sign_in user }

      describe "visiting Users#edit page" do
        before { visit edit_user_path(wrong_user) }
        it {  have_selector('title', content: full_title(user.name)) }
      end

      describe "submitting a PUT request to the Users#update action" do
        before { put user_path(wrong_user) }
        specify { should redirect_to(signin_path) }
      end
    end
    
    describe "as non-admin user" do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin }

      describe "submitting a DELETE request to the Users#destroy action" do
        before { delete user_path(user) }
        specify { response.should redirect_to(signin_path) }
      end
    end

   
    
  end

end