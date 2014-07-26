# == Schema Information
#
# Table name: direct_messages
#
#  id           :integer          not null, primary key
#  content      :string(255)
#  sender_id    :integer
#  recipient_id :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#


require 'spec_helper'

describe DirectMessage do
  

  let(:sender) { FactoryGirl.create(:user, name: 'sndr', email: 's@example.com') }
  let(:recipient) { FactoryGirl.create(:user, name: 'rcpnt', email: 'r@example.com') }
  before {  
   @direct_message = DirectMessage.create!( sender_id: sender.id, recipient_id: recipient.id, content: 'some content')
  }

  before(:each) do
     ActionMailer::Base.delivery_method = :test
     # ActionMailer::Base.perform_deliveries = true  
     ActionMailer::Base.deliveries.clear
  end

   subject { @direct_message }
  
  it { should be_valid }
  it { should respond_to(:content) }
  it { should respond_to(:recipient_id) }
  it { should respond_to(:sender_id) }

  context  "should not be valid without a sender" do
    before { @direct_message.sender_id = nil } 
    it { should_not be_valid }
  end

  context  "should not be valid without a sender" do
    before { @direct_message.recipient_id = nil } 
    it { should_not be_valid }
  end

  context  "should not be valid without a sender" do
    before { @direct_message.content = " " } 
    it { should_not be_valid }
  end

end
