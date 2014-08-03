#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Users" do


 subject { page }

  before(:each) do
   ActionMailer::Base.delivery_method = :test
  end 

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
          should have_selector('li', content: user.name)
        end
      end
    end

    describe "delete links" do
      subject { page }

      it { should_not have_link('delete') }

      describe "as an admin user" do
        let(:admin) { FactoryGirl.create(:admin) }
        before do
          sign_in admin
          visit users_path
        end
        
        it { should have_link('delete', href: user_path(User.first)) }
        it "should be able to delete another user" do
           expect do click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
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
    before { sign_in user 
      visit user_path(user) }
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

    
    describe "with valid information"  do

      before do
        fill_in "Имя",          with: "Example User"
        fill_in "Ник",          with: "Example"
        fill_in "Мыло",         with: "worksgo@yandex.ru"
        fill_in "Пароль",       with: "foobar"
        fill_in "Confirm Password", with: "foobar"

      end

      it "should create a user" do
        expect { click_button submit }.to change(User, :count).by(1)
        
      end
      
      

      describe "after saving the user"  do
        
        before do
          click_button submit
        end
                     
        let(:user) { User.find_by_email('worksgo@yandex.ru') }
        let(:mail) { UserMailer.welcome_email(user).deliver }
        
        
        describe "When the user is in the active state" do
         it { user.state.should == "inactive" } 
         it { should have_content("To complete registration, please check your") }
        end

        describe "When the user is in the active state" do
         
          before(:each) do
           user.confirmate
           visit signin_path
           fill_in "Email",    with: "worksgo@yandex.ru"
           fill_in "Password", with: "foobar"
           click_button "Sign in"              
          end
          
          it { user.state.should == "active" }
          it { should have_selector('title', content: 'Example User') }
          it { should have_title(user.name) }
          it { should have_link('Выйти') }

         describe "GET 'feed'" do
          
          it "should show an rss feed with 10 microposts of the user in question" do
           11.times { |i| user.microposts.create!(content: "micropost #{i+1}") }
           visit feed_user_path(user, format: :rss)
 
           10.times do |n|
           # search for contents "micropost 11" to "micropost 2" because
           # micropost is queried from the latest (i.e. micropost 11)
           page.should have_selector("title", content: "micropost #{n+2}")
           end
           # response should not contain the earliest micropost (i.e. micropost 1)
           response.should_not contain(/^micropost 1$/)
          end
 
          it "should be accessible even if the user is not logged in" do
            visit feed_user_path(user, format: :rss)
            page.should_not have_content_h1_title('Sign in') 
          end
         end

        end
        
        

        describe "Mailer" do
                             
         it "should create a mail" do
           ActionMailer::Base.deliveries.clear
           mail
           ActionMailer::Base.deliveries.count.should == 1 
         end

         it 'renders the subject' do
            expect(mail.subject).to eql('Welcome to My Awesome Site')
         end
           
         it 'renders the receiver email' do
           expect(mail.to).to eql([user.email])
         end
           
        end

      end
    end

  end

  describe "direct_messages" do
   let(:user) { FactoryGirl.create(:user) }
    before { 
       sign_in user
            }
    it { should have_link('Приватное сообщение', href: received_direct_messages_path) }

    context "within Direct Messages link" do

      it "should have a 'Sent Items' link" do
        visit root_path
        click_link 'Приватное сообщение'
        should have_selector("a", href: sent_direct_messages_path,
                                           content:  "Отправленные сообщения")
      end

      it "should have a 'Received Items' link" do
        visit root_path
        click_link 'Приватное сообщение'
        click_link "Отправленные сообщения"
        should have_selector("a", href: received_direct_messages_path,
                                           content: "Полученные сообщения")
      end
    end

  end

  describe "edit"  do
    let(:user) { FactoryGirl.create(:user) }
    before { 
       sign_in user
       visit edit_user_path(user)
       }

    describe "page" do
      it { should have_selector('h1',    content: "Update your profile") }
      it { should have_selector('title', content: user.name) }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe "with invalid information" do
    
      before { click_button "Save changes" }

      it { should have_content('error') }
      it { should have_selector("div#error_explanation") }

    end

    describe "with valid information" do
      let(:new_name)  { "New Name" }
      let(:new_email) { "new@example.com" }
      let(:new_nickname) { "Test" }
      before do
        fill_in "Имя",             with: new_name
        fill_in "Ник",             with: new_nickname
        fill_in "Мыло",            with: new_email
        fill_in "Пароль",          with: user.password
        fill_in "Confirm Password", with: user.password
        click_button "Save changes"
      end

      it { should have_selector('title', content: new_name) }
      it { should have_selector('div.alert.alert-success') }
      it { should have_link('Выйти', href: signout_path) }
      specify { user.reload.name.should  == new_name }
      specify { user.reload.email.should == new_email }
    end

  end

  describe "profile page" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:m1) { FactoryGirl.create(:micropost, user: user, content: "Foo") }
    let!(:m2) { FactoryGirl.create(:micropost, user: user, content: "Bar") }

   
    before { sign_in user
             visit user_path(user) }



    it { should have_selector('h1',    content: user.name) }
    it { should have_selector('title', content: user.name) }
    it { should have_selector('span',  content: user.handle)}
    
    it "should have a link to the feed-rss of the current user being shown" do
       page.should have_selector("a", href: feed_user_path(user, format: :rss))
    end
    
    describe "microposts" do
      it { should have_content(m1.content) }
      it { should have_content(m2.content) }
      it { should have_content(user.microposts.count) }
    end

    describe "follow/unfollow buttons" do
      let(:other_user) { FactoryGirl.create(:user) }
      before { sign_in user }

      describe "following a user" do
        before { visit user_path(other_user) }

        it "should increment the followed user count" do
          expect do
            click_button "Follow"
          end.to change(user.followed_users, :count).by(1)
        end

        it "should increment the other user's followers count" do
          expect do
            click_button "Follow"
          end.to change(other_user.followers, :count).by(1)
        end

        describe "toggling the button" do
          before { click_button "Follow" }
          it { should have_selector('input', value: 'Unfollow') }
        end
      end

      describe "unfollowing a user" do
        before do
          user.follow!(other_user)
          visit user_path(other_user)
        end

        it "should decrement the followed user count" do
          expect do
            click_button "Unfollow"
          end.to change(user.followed_users, :count).by(-1)
        end

        it "should decrement the other user's followers count" do
          expect do
            click_button "Unfollow"
          end.to change(other_user.followers, :count).by(-1)
        end

        describe "toggling the button" do
          before { click_button "Unfollow" }
          it { should have_selector('input', value: 'Follow') }
        end
      end
    end

  end


  describe "following/followers" do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe "followed users" do
      before do
        sign_in user
        visit following_user_path(user)
      end

      it { should have_selector('title', content: full_title('Following')) }
      it { should have_selector('h3', content: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
      it { should have_link('1 Читаемых', href: following_user_path(user)) }
      it { should have_link('0 Читающих', href: followers_user_path(user)) }
      describe "should change amount following on profile" do
       before do
         visit user_path(user)
       end
       it { should have_link('1 Читаемых', href: following_user_path(user)) }
       it { should have_link('0 Читающих', href: followers_user_path(user)) }
      end
    end

    describe "followers" do
      before do
        sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_selector('title', content: full_title('Followers')) }
      it { should have_selector('h3', content: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
      it { should have_link('0 Читаемых', href: following_user_path(other_user)) }
      it { should have_link('1 Читающих', href: followers_user_path(other_user)) }
      
      describe "should change amount followers on profile" do
       before do
         visit user_path(other_user)
       end
       it { should have_link('0 Читаемых', href: following_user_path(other_user)) }
       it { should have_link('1 Читающих', href: followers_user_path(other_user)) }
      end
    end
  end
   
end
