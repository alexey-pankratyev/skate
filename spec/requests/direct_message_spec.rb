require 'spec_helper'
# encoding: utf-8
 describe "DirectMessage" do

  subject { page }

  let(:sender) { FactoryGirl.create(:userToReplyTo) }
  let(:recipient) { FactoryGirl.create(:userToReplyTo) }

   before(:each) do
     ActionMailer::Base.delivery_method = :test
     # ActionMailer::Base.perform_deliveries = true  
     ActionMailer::Base.deliveries.clear
   end

  describe "DirectMessage creation" do

   	before { sign_in sender }
    before { visit root_path }
    let(:direct_message) { 'd "Donald Duck " Lorem ipsum' }

     describe "works sender" do

      it "should create and show sent a DirectMessage" do
        expect { post_micropost direct_message  }.to change(DirectMessage, :count).by(1)
        visit sent_direct_messages_path
        should have_text("Lorem ipsum") 
      end

    end
 
     describe "works recipient" do

      it "should show recipient page a DirectMessage" do
      	expect { post_micropost direct_message  }.to change(DirectMessage, :count).by(1)
        visit received_direct_messages_path
        should have_text("Lorem ipsum") 
      end

    end

    describe "no works sender" do

      it "should not appear at the sender's received messages page" do
        visit sent_direct_messages_path
        should_not have_text("Lorem ipsum") 
      end

    end

    describe "no works recipient" do

      it "should not appear at the recipient's sent messages page" do
        visit received_direct_messages_path
        should_not have_text("Lorem ipsum") 
      end

    end

    describe "should not appear at the user's feed" do

      it "should not appear at the recipient's sent messages page" do
        visit root_path
        should_not have_text("Lorem ipsum") 
      end

    end

    it "should not be saved into the microposts table" do
        expect { post_micropost direct_message  }.to change(Micropost, :count).by(0)
    end

    describe "DirectMessage Pagination" do

      before do 
      	 33.times { post_micropost 'd "   Donald Duck   " Lorem ipsum' }
      	 visit sent_direct_messages_path 	
      end

      it { should have_selector('div.pagination') } 

    end

  end

end