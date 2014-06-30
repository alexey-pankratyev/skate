#!/bin/env ruby
# encoding: utf-8

require 'spec_helper'

  describe "FollowerNotifications" do

   EMAILS = ActionMailer::Base.deliveries
 
   before(:each) do
     @follower = FactoryGirl.create(:user, email: "fr@example.com", :name => "fr")
     @followed = FactoryGirl.create(:user, email: "fd@example.com", :name => "fd")
     ActionMailer::Base.delivery_method = :test
     # ActionMailer::Base.perform_deliveries = true  
     ActionMailer::Base.deliveries.clear
   end
 
   context "when turned on" do
     it "should be emailed to users when someone starts following them" do
       expect {
         integration_follow(followed: @followed, follower: @follower)
       }.to change(EMAILS, :size).by(1)
 
       recipient = EMAILS.last.to
       recipient.should == [ @followed.email ]
 
       email_body = EMAILS.last.body.encoded
       email_body.should  match( "Имя: #{@follower.name} Ник:#{@follower.nickname}" )
     end
   end
 
   context "when turned off" do
     it "should NOT be emailed to users when someone starts following them" do
       expect {
         @followed.toggle!(:follower_notifications) # from true(default) to false
         integration_follow(followed: @followed, follower: @follower)
       }.to change(EMAILS, :size).by(0)
     end
   end
 
   private
 
   def integration_follow( options )
   	 sign_in options[:follower]
     visit user_path( options[:followed] )
     click_button  "Follow"
   end
 end