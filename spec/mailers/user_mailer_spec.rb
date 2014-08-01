#!/bin/env ruby
# encoding: utf-8
require "spec_helper"

describe UserMailer do
 
   describe "welcome_email"  do
   	   let(:user) { FactoryGirl.create(:user) }
       let(:mail) { UserMailer.welcome_email(user).deliver }
       
       before(:each) do
            ActionMailer::Base.delivery_method = :test
            # ActionMailer::Base.perform_deliveries = true  
            ActionMailer::Base.deliveries.clear
       end
       
       it 'renders the subject' do
         expect(mail.subject).to eql('Welcome to My Awesome Site')
       end
       
       it 'renders the receiver email' do
         expect(mail.to).to eql([user.email])
       end

       it 'renders the sender email' do
         expect(mail.from).to eql(['alexey.pankratev@gmail.com'])
       end
        

        # it 'assigns @name' do
        #   email_body = UserMailer.welcome_email(user).deliver.body.encoded
        #   email_body.should match( "#{user.name}" )
        # end
 
       # it 'assigns @confirmation_url' do
       #   expect(mail.last.body.encoded).to match("https://mynda.herokuapp.com/, #{user.name} !")
       # end 

    end

end
