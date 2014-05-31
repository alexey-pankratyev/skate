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
  
  it { should respond_to(:content) }
  it { should respond_to(:recipient_id) }
  it { should respond_to(:sender_id) }


end
