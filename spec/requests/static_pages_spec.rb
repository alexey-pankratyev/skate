#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

describe "Static pages" do
  
 subject { page }

  shared_examples_for "all static pages" do
     it { should have_selector('h4', content: heading) }
     it { should have_selector('title', content: full_title(page_title)) }
  end

  shared_examples_for "p" do
     it { should have_selector('p', content: heading) }
     it { should have_selector('title', content: full_title(page_title)) }
  end
 
  describe "Home page" do 
     before { visit root_path }
       let(:heading)    { 'Мянда затерянный край вдали городов !!!' }
       let(:page_title) { '' }
       it_should_behave_like "all static pages"
       it { should_not have_selector 'title', text: '| Home' }

    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: "wrong@example.com") }
      before do
        # FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        # FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        content = Faker::Lorem.sentence(5)
        33.times { FactoryGirl.create(:micropost, user: user, content: content) }         
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed[1..28].each do |item|
          should have_selector("li##{item.id}", content: item.content)
          should have_link('delete') 
        end
      end

      describe "it should show the nick/handle" do
         it { should have_selector 'span', content: user.handle}
      end

      describe "follower/following counts" do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end

        it { should have_link("0 Читаемых", href: following_user_path(user)) }
        it { should have_link("1 Читающих", href: followers_user_path(user)) }
      end

      it "should have micropost count and pluralize" do
        should have_content('33 microposts')
      end

      it "should paginate after 31" do
        should have_selector('div.pagination')
      end

      describe "check link 'delete' user" do
        before { sign_in  wrong_user}
        before { get user_path(user) }
         it "should_not the user's links 'delete'" do
          user.feed[1..28].each do |item|
          should_not have_link('delete') 
          end
         end
      end

      it "should show the nicks" do
           user.feed[1..28].each do |item|
             should have_selector("li##{item.id}", content: item.user.handle)
           end
      end

    end
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
     it { should have_text("Моя любимая жена!") } 
     it { should have_title(full_title('Contact')) }
  end
  
  describe "Email page" do
    before { visit '/email' }
     it { should have_text("Пример для саита!") } 
     it { should have_selector('title', content: full_title('Email')) }
  end

  describe "Reviews page" do
    before { visit 'reviews' }
    it { should have_text("Пример для саита!") } 
    it { should have_selector('title', content: full_title('Reviews')) }
  end

  it "should have the right links on the layout" do
    visit '/'
    click_link "Цены"
    should have_selector 'title', content: full_title('About')
   end

 end
